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
      puts "Failed to save record: #{record.errors.full_messages.join(", ")}"
    end
  end

  def partner_details
    @record = Record.find(params[:id])
    @related_records = Record.where(company_name: @record.company_name)
  end

  private

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
