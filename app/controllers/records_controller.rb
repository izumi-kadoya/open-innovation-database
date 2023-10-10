require 'csv'
require 'net/http'
require 'uri'
require 'json'
class RecordsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_record, only: [:show, :edit, :partner_details]

  def index
    # 並び順
    order_key = case params[:order_by]
                when 'company_name'
                  'company_name ASC'
                when 'company_name_desc'
                  'company_name DESC'
                when 'created_at'
                  'MIN(created_at) DESC'
                else
                  'company_name' # デフォルトのソート順
                end
    @companies = Record.select('company_name, MIN(id) as id, MIN(created_at) as created_at').group(:company_name).order(order_key).map do |r|
      [r.company_name, r.id]
    end
  end

  def show
    @related_records = Record.where(company_name: @record.company_name)
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.new
    uploaded_io = params[:record][:csv]

    if uploaded_io
      unless valid_csv_file?(uploaded_io)
        flash.now[:alert] = 'Uploaded file is not a valid CSV.'
        render :new and return
      end
      failed_records = [] # 保存に失敗した行のエラーメッセージを保存するための配列
      CSV.foreach(uploaded_io.path, headers: true) do |row|
        record = Record.new(map_row_to_record(row))
        failed_records << record.errors.full_messages.join(', ') unless record.save # 保存が失敗した場合、エラーメッセージを配列に追加
      end

      if failed_records.empty?
        redirect_to records_path, notice: 'CSV was successfully uploaded.'
      else
        # 保存に失敗したレコードのエラーメッセージを表示
        flash.now[:alert] = "Failed to save some records: #{failed_records.join('. ')}"
        render :new
      end
    else
      flash.now[:alert] = 'No file uploaded'
      render :new
    end
  end

  def edit
  end

  def update
    record = Record.find(params[:id])
    record.update(record_params)
    redirect_to partner_details_record_path
  end

  def partner_details
    @related_records = Record.where(company_name: @record.company_name)

    # ◀︎ 同じ company_name を持ち、現在のレコードより id が小さい最大のレコードを取得
    @previous_record = Record.where('company_name = ? AND id < ?', @record.company_name, @record.id).order(id: :desc).first

    # ▶︎ 同じ company_name を持ち、現在のレコードより id が大きい最小のレコードを取得
    @next_record = Record.where('company_name = ? AND id > ?', @record.company_name, @record.id).order(id: :asc).first
    @api_key = ENV['OPENAI_API_SECRET_KEY']
  end

  def filter_by_industry
    order_key = 'company_name' # 業種で絞り込む際のデフォルトのソート順
    @companies = Record.select('company_name, MIN(id) as id').where(company_industry: params[:industry]).group(:company_name).order(order_key).map do |r|
      [r.company_name, r.id]
    end
    render :index
  end

  # CSVダウンロード
  def download
    authorize! :download, Record
    @records = if params[:company_industry].present?
                 Record.where(company_industry: params[:company_industry])
               else
                 Record.all
               end

    respond_to do |format|
      format.html
      format.csv { send_data to_csv(@records), filename: "#{params[:company_industry]}-records-#{Date.today}.csv" }
    end
  end

  def download_page
  end

  # API連携でデータを再取得
  def access_openai_description
    result = fetch_from_openai(params[:prompt])
    render json: result
  end

  def access_openai_summary
    result = fetch_from_openai(params[:article_summary])
    render json: result
  end

  # renewした内容を保存する
  def save_business_description
    @record = Record.find(params[:id])
    @record.business_description = params[:business_description]

    if @record.save
      render json: { success: true }
    else
      render json: { success: false }, status: 422
    end
  end

  def save_article_summary
    @record = Record.find(params[:id])
    @record.article_summary = params[:article_summary]

    if @record.save
      render json: { success: true }
    else
      render json: { success: false }, status: 422
    end
  end

  def text_to_speech
    text = params[:text]
    api_key = ENV['GOOGLE_CLOUD_API_KEY']
  
    response = fetch_text_to_speech(api_key, text)
  
    if response.code == "200"
      render json: { audioContent: JSON.parse(response.body)["audioContent"] }
    else
      render json: { error: "Failed to get audio. Reason: #{response.body}" }, status: :bad_request
    end
  end

  # CanCanCanの例外を捉える（ゲストユーザーがリダイレクトされた時）
  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, alert: 'You do not have the necessary permissions. Please log in.'
  end

  ## ここからprivate ##
  private

  def set_record
    @record = Record.find(params[:id])
  end

  def record_params
    params.require(:record).permit(
      :csv,
      :company_industry,
      :company_name,
      :article_date,
      :business_partner,
      :country,
      :url,
      :description,
      :business_description,
      :news_snippet,
      :article,
      :article_summary,
      :sub_industry,
      :founded_year,
      :latest_funding_round,
      :latest_funding_date,
      :latest_funding_investors,
      :total_funding,
      :all_investors,
      :exit_date,
      :acquirers,
      :latest_valuation,
      :city,
      :comment1,
      :comment2,
      :comment3,
      :comment4
    )
  end

  # 日付のシリアル値をdate型に変更
  def from_excel_serial_date(serial_date)
    base_date = Date.new(1899, 12, 31)
    adjusted_serial_date = serial_date.to_i
    adjusted_serial_date -= 1 if adjusted_serial_date > 60 # Excelの1900-02-29のバグを考慮
    base_date + adjusted_serial_date.days
  end

  def map_row_to_record(row)
    {
      company_industry: row['company_industry'],
      company_name: row['company_name'],
      article_date: from_excel_serial_date(row['article_date']),
      business_partner: row['business_partner'],
      country: row['country'],
      url: row['url'],
      description: row['description'],
      business_description: row['business_description'],
      news_snippet: row['news_snippet'],
      article: row['article'],
      article_summary: row['article_summary'],
      sub_industry: row['sub_industry'],
      founded_year: row['founded_year'].to_i,
      latest_funding_round: row['latest_funding_round'],
      latest_funding_date: from_excel_serial_date(row['latest_funding_date']),
      latest_funding_investors: row['latest_funding_investors'],
      total_funding: row['total_funding'].to_d,
      all_investors: row['all_investors'],
      exit_date: from_excel_serial_date(row['exit_date']),
      acquirers: row['acquirers'],
      latest_valuation: row['latest_valuation'].to_d,
      city: row['city'],
      comment1: row['comment1'],
      comment2: row['comment2'],
      comment3: row['comment3'],
      comment4: row['comment4']
    }
  end

  def valid_csv_file?(uploaded_io)
    File.extname(uploaded_io.original_filename).downcase == '.csv'
  end

  # API連携でデータの再取得
  def fetch_from_openai(prompt)
    api_key = ENV['OPENAI_API_SECRET_KEY']
    uri = URI.parse('https://api.openai.com/v1/completions')
    request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = 'application/json'
    request['Authorization'] = "Bearer #{api_key}"
    request.body = JSON.dump({
                               "model": 'text-davinci-003',
                               "prompt": prompt,
                               "max_tokens": 400
                             })

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  end

  # 読み上げ
  def fetch_text_to_speech(api_key, text)
    uri = URI.parse("https://texttospeech.googleapis.com/v1/text:synthesize?key=#{api_key}")
  
    request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    request.body = JSON.dump({
                               input: {
                                 text: text
                               },
                               voice: {
                                 languageCode: 'en-US',
                                 ssmlGender: 'NEUTRAL'
                               },
                               audioConfig: {
                                 audioEncoding: 'MP3'
                               }
                             })
  
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  end
  # ダウンロード
  def to_csv(records)
    CSV.generate(headers: true) do |csv|
      csv << %w[
        company_industry
        company_name
        article_date
        business_partner
        country
        url
        description
        business_description
        news_snippet
        article
        article_summary
        sub_industry
        founded_year
        latest_funding_round
        latest_funding_date
        latest_funding_investors
        total_funding
        all_investors
        exit_date
        acquirers
        latest_valuation
        city
        comment1
        comment2
        comment3
        comment4
      ]

      records.each do |record|
        csv << [
          record.company_industry,
          record.company_name,
          record.article_date,
          record.business_partner,
          record.country,
          record.url,
          record.description,
          record.business_description,
          record.news_snippet,
          record.article,
          record.article_summary,
          record.sub_industry,
          record.founded_year,
          record.latest_funding_round,
          record.latest_funding_date,
          record.latest_funding_investors,
          record.total_funding,
          record.all_investors,
          record.exit_date,
          record.acquirers,
          record.latest_valuation,
          record.city,
          record.comment1,
          record.comment2,
          record.comment3,
          record.comment4
        ]
      end
    end
  end
end
