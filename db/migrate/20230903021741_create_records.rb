class CreateRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :records do |t|
      t.string :company_name
      t.date :dl_date
      t.string :business_partner
      t.string :company_type
      t.string :country
      t.text :news_snippet
      t.string :url
      t.text :description
      t.text :business_description
      t.text :article_summary
      t.text :text
      t.string :sector
      t.string :industry
      t.string :sub_industry
      t.text :competitors
      t.integer :founded_year
      t.string :latest_funding_round
      t.date :latest_funding_date
      t.decimal :latest_funding_amount
      t.string :latest_funding_simplified_round
      t.text :latest_funding_investors
      t.decimal :total_funding
      t.text :all_investors
      t.date :link_date # 'Date'というカラム名が2回出てきたので名前を変更しました
      t.string :link
      t.string :expert_tag
      t.date :date_added
      t.string :added_by
      t.date :date_last_edited
      t.string :last_edited_by
      t.string :company_status
      t.date :exit_date
      t.text :acquirers
      t.decimal :latest_valuation
      t.string :city
      t.timestamps
    end
  end
end
