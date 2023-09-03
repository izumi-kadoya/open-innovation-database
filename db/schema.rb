# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_03_021741) do
  create_table "records", charset: "utf8mb4", force: :cascade do |t|
    t.string "company_name"
    t.date "dl_date"
    t.string "business_partner"
    t.string "company_type"
    t.string "country"
    t.text "news_snippet"
    t.string "url"
    t.text "description"
    t.text "business_description"
    t.text "article_summary"
    t.text "text"
    t.string "sector"
    t.string "industry"
    t.string "sub_industry"
    t.text "competitors"
    t.integer "founded_year"
    t.string "latest_funding_round"
    t.date "latest_funding_date"
    t.decimal "latest_funding_amount", precision: 10
    t.string "latest_funding_simplified_round"
    t.text "latest_funding_investors"
    t.decimal "total_funding", precision: 10
    t.text "all_investors"
    t.date "link_date"
    t.string "link"
    t.string "expert_tag"
    t.date "date_added"
    t.string "added_by"
    t.date "date_last_edited"
    t.string "last_edited_by"
    t.string "company_status"
    t.date "exit_date"
    t.text "acquirers"
    t.decimal "latest_valuation", precision: 10
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
