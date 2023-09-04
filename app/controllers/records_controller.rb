require 'csv'
class RecordsController < ApplicationController
  def index
    @companies = Record.select('company_name, MIN(id) as id').group(:company_name).map { |r| [r.company_name, r.id] }
  end

  def show
    @record = Record.find(params[:id])
    @related_records = Record.where(company_name: @record.company_name)
  end

  def new
    @record = Record.new
  end

  def create
    uploaded_io = record_params[:csv]

    if uploaded_io
      CSV.foreach(uploaded_io.path, headers: true) do |row|
        Record.create(map_row_to_record(row))
      end
      redirect_to records_path, notice: 'CSV was successfully uploaded.'
    else
      render :new
    end
  end

  def partner_details
    @record = Record.find(params[:id])
  end

  private

  def record_params
    params.require(:record).permit(
      :csv, 
      :company_name, 
      :dl_date, 
      :business_partner, 
      :company_type, 
      :country, 
      :news_snippet, 
      :url, 
      :description, 
      :business_description, 
      :article_summary, 
      :text, 
      :sector, 
      :industry, 
      :sub_industry, 
      :competitors, 
      :founded_year, 
      :latest_funding_round, 
      :latest_funding_date, 
      :latest_funding_amount, 
      :latest_funding_simplified_round, 
      :latest_funding_investors, 
      :total_funding, 
      :all_investors, 
      :link_date, 
      :link, 
      :expert_tag, 
      :date_added, 
      :added_by, 
      :date_last_edited, 
      :last_edited_by, 
      :company_status, 
      :exit_date, 
      :acquirers, 
      :latest_valuation, 
      :city
    )
  end


  def from_excel_serial_date(serial_date)
    # Excelのシリアル日付値の基点は1900年1月1日
    base_date = Date.new(1900, 1, 1)
    adjusted_serial_date = serial_date.to_i - (serial_date.to_i > 59 ? 2 : 1) # Excelの1900年2月29日のバグを考慮
    base_date + adjusted_serial_date.days
  end
  def map_row_to_record(row)
    {
      company_name: row['company_name'],
      dl_date: from_excel_serial_date(row['dl_date']),
      business_partner: row['business_partner'],
      company_type: row['company_type'],
      country: row['country'],
      news_snippet: row['news_snippet'],
      url: row['url'],
      description: row['description'],
      business_description: row['business_description'],
      article_summary: row['article_summary'],
      text: row['text'],
      sector: row['sector'],
      industry: row['industry'],
      sub_industry: row['sub_industry'],
      competitors: row['competitors'],
      founded_year: row['founded_year'].to_i,
      latest_funding_round: row['latest_funding_round'],
      latest_funding_date: from_excel_serial_date(row['latest_funding_date']),
      latest_funding_amount: row['latest_funding_amount'].to_d,
      latest_funding_simplified_round: row['latest_funding_simplified_round'],
      latest_funding_investors: row['latest_funding_investors'],
      total_funding: row['total_funding'].to_d,
      all_investors: row['all_investors'],
      link_date: from_excel_serial_date(row['link_date']),
      link: row['link'],
      expert_tag: row['expert_tag'],
      date_added: from_excel_serial_date(row['date_added']),
      added_by: row['added_by'],
      date_last_edited: from_excel_serial_date(row['date_last_edited']),
      last_edited_by: row['last_edited_by'],
      company_status: row['company_status'],
      exit_date: from_excel_serial_date(row['exit_date']),
      acquirers: row['acquirers'],
      latest_valuation: row['latest_valuation'].to_d,
      city: row['city']
    }
  end
  

end
