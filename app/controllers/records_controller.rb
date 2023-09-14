require 'csv'
require 'pycall/import'
include PyCall::Import
class RecordsController < ApplicationController
  load_and_authorize_resource
  before_action :set_record, only: [:show, :edit,:partner_details,:fetch_info]

  def index
    # 並び順
    order_key = case params[:order_by]
                when 'company_name'
                  'company_name ASC'
                when 'created_at'
                  'MIN(created_at) DESC'
                else
                  'company_name'  # デフォルトのソート順
                end
    @companies = Record.select('company_name, MIN(id) as id, MIN(created_at) as created_at').group(:company_name).order(order_key).map { |r| [r.company_name, r.id] }
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
        flash.now[:alert] = "Uploaded file is not a valid CSV."
        render :new and return
      end
      failed_records = []  # 保存に失敗した行のエラーメッセージを保存するための配列
      CSV.foreach(uploaded_io.path, headers: true) do |row|
        record = Record.new(map_row_to_record(row))
        unless record.save  # 保存が失敗した場合、エラーメッセージを配列に追加
          failed_records << record.errors.full_messages.join(", ")
        end
      end
  
      if failed_records.empty?
        redirect_to records_path, notice: 'CSV was successfully uploaded.'
      else
        # 保存に失敗したレコードのエラーメッセージを表示
        flash.now[:alert] = "Failed to save some records: #{failed_records.join('. ')}"
        render :new
      end
    else
      flash.now[:alert] = "No file uploaded"
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
    @previous_record = Record.where("company_name = ? AND id < ?", @record.company_name, @record.id).order(id: :desc).first
    # ▶︎ 同じ company_name を持ち、現在のレコードより id が大きい最小のレコードを取得
    @next_record = Record.where("company_name = ? AND id > ?", @record.company_name, @record.id).order(id: :asc).first
  
  end

  def filter_by_industry
    order_key = 'company_name'  # 業種で絞り込む際のデフォルトのソート順
    @companies = Record.select('company_name, MIN(id) as id').where(company_industry: params[:industry]).group(:company_name).order(order_key).map { |r| [r.company_name, r.id] }
    render :index
  end

  def download
    authorize! :download, Record
    if params[:company_industry].present?
      @records = Record.where(company_industry: params[:company_industry])
    else
      @records = Record.all
    end
  
    respond_to do |format|
      format.html
      format.csv { send_data to_csv(@records), filename: "#{params[:company_industry]}-records-#{Date.today}.csv" }
    end
  end
  
  def download_page
  end


  def fetch_info
    url = @record.url 
    
    # pycallでPythonの関数を呼び出す
    PyCall.sys.path.append(File.expand_path('./python_scripts'))
    pyimport 'scripts', as: 'integration_script'
    description = integration_script.fetch_description(url)
    
    if description  # 返された内容のチェック（エラーハンドリングは適宜調整してください）
      render json: { description: description }
    else
      render json: { error: 'Failed to fetch description from the script.' }, status: :internal_server_error
    end
  end
  


  # ここからprivate
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
    File.extname(uploaded_io.original_filename).downcase == ".csv"
  end

  # ダウンロード
  def to_csv(records)
    CSV.generate(headers: true) do |csv|
      csv << [
        "company_industry",
        "company_name",
        "article_date",
        "business_partner",
        "country",
        "url",
        "description",
        "business_description",
        "article_summary",
        "sub_industry",
        "founded_year",
        "latest_funding_round",
        "latest_funding_date",
        "latest_funding_investors",
        "total_funding",
        "all_investors",
        "exit_date",
        "acquirers",
        "latest_valuation",
        "city",
        "comment1",
        "comment2",
        "comment3",
        "comment4"
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
