class CreateRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :records do |t|
      t.string :csv
      t.string :company_industry
      t.string :company_name
      t.date :article_date
      t.string :business_partner
      t.string :country
      t.string :url
      t.text :description
      t.text :business_description
      t.text :news_snippet
      t.text :article
      t.text :article_summary
      t.string :sub_industry
      t.integer :founded_year
      t.string :latest_funding_round
      t.date :latest_funding_date
      t.text :latest_funding_investors
      t.decimal :total_funding
      t.text :all_investors
      t.date :exit_date
      t.text :acquirers
      t.decimal :latest_valuation
      t.string :city
      t.string :comment1
      t.string :comment2
      t.string :comment3
      t.text :comment4
      t.timestamps
    end
  end
end
