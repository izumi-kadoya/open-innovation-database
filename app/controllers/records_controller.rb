require 'csv'

class RecordsController < ApplicationController

  before_action :set_record, only: [:show, :edit,:partner_details]
  def index
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
  end

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
end
