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

ActiveRecord::Schema[7.0].define(version: 2023_09_03_075224) do
  create_table "records", charset: "utf8", force: :cascade do |t|
    t.string "csv"
    t.string "company_industry"
    t.string "company_name"
    t.date "article_date"
    t.string "business_partner"
    t.string "country"
    t.string "url"
    t.text "description"
    t.text "business_description"
    t.text "news_snippet"
    t.text "article"
    t.text "article_summary"
    t.string "sub_industry"
    t.integer "founded_year"
    t.string "latest_funding_round"
    t.date "latest_funding_date"
    t.text "latest_funding_investors"
    t.decimal "total_funding", precision: 10
    t.text "all_investors"
    t.date "exit_date"
    t.text "acquirers"
    t.decimal "latest_valuation", precision: 10
    t.string "city"
    t.string "comment1"
    t.string "comment2"
    t.string "comment3"
    t.text "comment4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "nickname", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "admin", default: false
    t.boolean "approved", default: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
