# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_02_155134) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commercial_calculations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.boolean "open", default: true, null: false
    t.bigint "date_id"
    t.integer "goal_leads", default: 0
    t.decimal "goal_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "goal_gain", precision: 15, scale: 2, default: "0.0"
    t.integer "marketing_leads", default: 0
    t.integer "sales_leads", default: 0
    t.decimal "total_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "total_gain", precision: 15, scale: 2, default: "0.0"
    t.decimal "total_lost", precision: 15, scale: 2, default: "0.0"
    t.integer "base_leads", default: 0
    t.decimal "base_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "base_gain", precision: 15, scale: 2, default: "0.0"
    t.integer "referrer_leads", default: 0
    t.decimal "referrer_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "referrer_gain", precision: 15, scale: 2, default: "0.0"
    t.integer "landing_leads", default: 0
    t.decimal "landing_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "landing_gain", precision: 15, scale: 2, default: "0.0"
    t.integer "event_leads", default: 0
    t.decimal "event_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "event_gain", precision: 15, scale: 2, default: "0.0"
    t.integer "total_tickets", default: 0
    t.integer "total_calls", default: 0
    t.integer "total_contacts", default: 0
    t.integer "total_in_process", default: 0
    t.integer "prospecting_count", default: 0
    t.integer "qualification_count", default: 0
    t.integer "booking_count", default: 0
    t.integer "meeting_count", default: 0
    t.integer "proposal_count", default: 0
    t.integer "closing_count", default: 0
    t.integer "gain_count", default: 0
    t.integer "lost_count", default: 0
    t.decimal "prospecting_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "qualification_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "booking_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "meeting_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "proposal_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "closing_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "gain_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "lost_amount", precision: 15, scale: 2, default: "0.0"
    t.index ["active"], name: "index_commercial_calculations_on_active"
    t.index ["date_id"], name: "index_commercial_calculations_on_date_id"
  end

  create_table "commercial_dates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.boolean "open", default: true, null: false
    t.integer "month"
    t.integer "year"
    t.string "token"
    t.index ["active"], name: "index_commercial_dates_on_active"
    t.index ["month"], name: "index_commercial_dates_on_month"
    t.index ["open"], name: "index_commercial_dates_on_open"
    t.index ["token"], name: "index_commercial_dates_on_token", unique: true
    t.index ["year"], name: "index_commercial_dates_on_year"
  end

  create_table "commercial_marketing_event_attendees", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.string "name"
    t.string "last_name"
    t.string "email"
    t.string "ddd"
    t.string "number"
    t.string "crm"
    t.string "crm_state"
    t.string "med_school"
    t.string "token"
    t.string "slug"
    t.integer "graduation"
    t.integer "kind"
    t.index ["active"], name: "index_commercial_marketing_event_attendees_on_active"
    t.index ["email"], name: "index_commercial_marketing_event_attendees_on_email", unique: true
    t.index ["graduation"], name: "index_commercial_marketing_event_attendees_on_graduation"
    t.index ["kind"], name: "index_commercial_marketing_event_attendees_on_kind"
    t.index ["slug"], name: "index_commercial_marketing_event_attendees_on_slug", unique: true
    t.index ["token"], name: "index_commercial_marketing_event_attendees_on_token", unique: true
  end

  create_table "commercial_marketing_event_entities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.string "name"
    t.string "title"
    t.string "slug"
    t.text "description"
    t.string "copy"
    t.string "meta_title"
    t.text "meta_description"
    t.string "meta_keywords"
    t.string "token"
    t.text "notes"
    t.integer "sharing"
    t.integer "kind"
    t.date "date"
    t.date "published_at"
    t.boolean "published", default: false, null: false
    t.boolean "blocked", default: true, null: false
    t.boolean "finished", default: false, null: false
    t.index ["active"], name: "index_commercial_marketing_event_entities_on_active"
    t.index ["blocked"], name: "index_commercial_marketing_event_entities_on_blocked"
    t.index ["copy"], name: "index_commercial_marketing_event_entities_on_copy"
    t.index ["date"], name: "index_commercial_marketing_event_entities_on_date"
    t.index ["description"], name: "index_commercial_marketing_event_entities_on_description"
    t.index ["finished"], name: "index_commercial_marketing_event_entities_on_finished"
    t.index ["kind"], name: "index_commercial_marketing_event_entities_on_kind"
    t.index ["meta_description"], name: "index_commercial_marketing_event_entities_on_meta_description"
    t.index ["meta_keywords"], name: "index_commercial_marketing_event_entities_on_meta_keywords"
    t.index ["meta_title"], name: "index_commercial_marketing_event_entities_on_meta_title"
    t.index ["name"], name: "index_commercial_marketing_event_entities_on_name"
    t.index ["published"], name: "index_commercial_marketing_event_entities_on_published"
    t.index ["sharing"], name: "index_commercial_marketing_event_entities_on_sharing"
    t.index ["slug"], name: "index_commercial_marketing_event_entities_on_slug", unique: true
    t.index ["title"], name: "index_commercial_marketing_event_entities_on_title"
    t.index ["token"], name: "index_commercial_marketing_event_entities_on_token", unique: true
  end

  create_table "commercial_marketing_landing_leads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.string "name"
    t.string "email"
    t.string "ddd"
    t.string "number"
    t.string "crm"
    t.string "crm_state"
  end

  create_table "commercial_sales_leads_entities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "date_id"
    t.integer "status"
    t.string "name"
    t.string "council_type"
    t.string "council_number"
    t.string "council_state"
    t.string "council"
    t.string "primary_source"
    t.string "link"
    t.string "token"
    t.string "email"
    t.string "uniq_phone"
    t.string "prefix"
    t.string "phone"
    t.string "notes"
    t.index ["active"], name: "index_commercial_sales_leads_entities_on_active"
    t.index ["council"], name: "index_commercial_sales_leads_entities_on_council"
    t.index ["council_number"], name: "index_commercial_sales_leads_entities_on_council_number"
    t.index ["council_state"], name: "index_commercial_sales_leads_entities_on_council_state"
    t.index ["date_id"], name: "index_commercial_sales_leads_entities_on_date_id"
    t.index ["primary_source"], name: "index_commercial_sales_leads_entities_on_primary_source"
    t.index ["status"], name: "index_commercial_sales_leads_entities_on_status"
    t.index ["token"], name: "index_commercial_sales_leads_entities_on_token"
  end

  create_table "commercial_sales_leads_sources", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "lead_id"
    t.integer "source"
    t.bigint "source_id"
    t.string "source_type"
    t.string "name"
    t.string "kind"
    t.string "email"
    t.string "prefix"
    t.string "phone"
    t.string "council"
    t.index ["active"], name: "index_commercial_sales_leads_sources_on_active"
    t.index ["kind"], name: "index_commercial_sales_leads_sources_on_kind"
    t.index ["lead_id"], name: "index_commercial_sales_leads_sources_on_lead_id"
    t.index ["name"], name: "index_commercial_sales_leads_sources_on_name"
    t.index ["source"], name: "index_commercial_sales_leads_sources_on_source"
    t.index ["source_id"], name: "index_commercial_sales_leads_sources_on_source_id"
    t.index ["source_type"], name: "index_commercial_sales_leads_sources_on_source_type"
  end

  create_table "commercial_sales_opportunities_entities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "date_id"
    t.bigint "prospector_id"
    t.bigint "closer_id"
    t.string "name"
    t.date "started_at"
    t.date "finished_at"
    t.integer "total_leads", default: 0
    t.decimal "total_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "total_gain", precision: 15, scale: 2, default: "0.0"
    t.decimal "total_lost", precision: 15, scale: 2, default: "0.0"
    t.integer "total_tickets", default: 0
    t.integer "total_calls", default: 0
    t.integer "total_contacts", default: 0
    t.integer "total_in_process", default: 0
    t.integer "source"
    t.integer "stage"
    t.integer "status"
    t.boolean "gain", default: false
    t.boolean "lost", default: false
    t.string "token"
    t.string "slug"
    t.string "notes"
    t.string "closer_name"
    t.string "prospector_name"
    t.index ["active"], name: "index_commercial_sales_opportunities_entities_on_active"
    t.index ["closer_id"], name: "index_commercial_sales_opportunities_entities_on_closer_id"
    t.index ["date_id"], name: "index_commercial_sales_opportunities_entities_on_date_id"
    t.index ["finished_at"], name: "index_commercial_sales_opportunities_entities_on_finished_at"
    t.index ["gain"], name: "index_commercial_sales_opportunities_entities_on_gain"
    t.index ["prospector_id"], name: "index_commercial_sales_opportunities_entities_on_prospector_id"
    t.index ["slug"], name: "index_commercial_sales_opportunities_entities_on_slug", unique: true
    t.index ["source"], name: "index_commercial_sales_opportunities_entities_on_source"
    t.index ["stage"], name: "index_commercial_sales_opportunities_entities_on_stage"
    t.index ["started_at"], name: "index_commercial_sales_opportunities_entities_on_started_at"
    t.index ["status"], name: "index_commercial_sales_opportunities_entities_on_status"
    t.index ["token"], name: "index_commercial_sales_opportunities_entities_on_token", unique: true
  end

  create_table "commercial_sales_opportunities_journeys", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "opportunity_id"
    t.integer "stage"
    t.datetime "date"
    t.index ["active"], name: "index_commercial_sales_opportunities_journeys_on_active"
    t.index ["date"], name: "index_commercial_sales_opportunities_journeys_on_date"
    t.index ["opportunity_id"], name: "index_commercial_sales_opportunities_journeys_on_opportunity_id"
    t.index ["stage"], name: "index_commercial_sales_opportunities_journeys_on_stage"
  end

  create_table "commercial_sales_opportunities_leads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "date_id"
    t.bigint "lead_id"
    t.bigint "opportunity_id"
    t.string "lead_name"
    t.string "lead_email"
    t.string "lead_phone"
    t.string "lead_council"
    t.index ["active"], name: "index_commercial_sales_opportunities_leads_on_active"
    t.index ["date_id"], name: "index_commercial_sales_opportunities_leads_on_date_id"
    t.index ["lead_id"], name: "index_commercial_sales_opportunities_leads_on_lead_id"
    t.index ["opportunity_id"], name: "index_commercial_sales_opportunities_leads_on_opportunity_id"
  end

  create_table "commercial_sales_opportunities_products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "date_id"
    t.bigint "opportunity_id"
    t.integer "name"
    t.integer "plan"
    t.integer "kind"
    t.decimal "amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "gain", precision: 15, scale: 2, default: "0.0"
    t.decimal "lost", precision: 15, scale: 2, default: "0.0"
    t.index ["active"], name: "index_commercial_sales_opportunities_products_on_active"
    t.index ["date_id"], name: "index_commercial_sales_opportunities_products_on_date_id"
    t.index ["kind"], name: "index_commercial_sales_opportunities_products_on_kind"
    t.index ["name"], name: "index_commercial_sales_opportunities_products_on_name"
    t.index ["opportunity_id"], name: "index_commercial_sales_opportunities_products_on_opportunity_id"
    t.index ["plan"], name: "index_commercial_sales_opportunities_products_on_plan"
  end

  create_table "commercial_sales_opportunities_tickets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "opportunity_id"
    t.string "body"
    t.date "due_at"
    t.integer "kind"
    t.integer "stage"
    t.integer "status"
    t.integer "flag"
    t.index ["active"], name: "index_commercial_sales_opportunities_tickets_on_active"
    t.index ["flag"], name: "index_commercial_sales_opportunities_tickets_on_flag"
    t.index ["kind"], name: "index_commercial_sales_opportunities_tickets_on_kind"
    t.index ["opportunity_id"], name: "index_commercial_sales_opportunities_tickets_on_opportunity_id"
    t.index ["stage"], name: "index_commercial_sales_opportunities_tickets_on_stage"
    t.index ["status"], name: "index_commercial_sales_opportunities_tickets_on_status"
  end

  create_table "financial_config_dates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.boolean "open", default: true, null: false
    t.integer "month"
    t.integer "year"
    t.string "token"
    t.index ["active"], name: "index_financial_config_dates_on_active"
    t.index ["month"], name: "index_financial_config_dates_on_month"
    t.index ["open"], name: "index_financial_config_dates_on_open"
    t.index ["token"], name: "index_financial_config_dates_on_token", unique: true
    t.index ["year"], name: "index_financial_config_dates_on_year"
  end

  create_table "financial_payable_entities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "date_id"
    t.bigint "chart_id"
    t.bigint "med_id"
    t.bigint "channel_id"
    t.bigint "provider_id"
    t.string "provider_name"
    t.datetime "due_date"
    t.datetime "accrual_date"
    t.decimal "amount", precision: 15, scale: 2
    t.string "description"
    t.string "chart_account"
    t.string "chart_name"
    t.integer "method"
    t.string "channel_name"
    t.string "bank_line"
    t.boolean "paid", default: false
    t.boolean "recurring", default: false
    t.boolean "splited", default: false
    t.integer "split"
    t.integer "installment"
    t.string "token"
    t.index ["accrual_date"], name: "index_financial_payable_entities_on_accrual_date"
    t.index ["active"], name: "index_financial_payable_entities_on_active"
    t.index ["channel_id"], name: "index_financial_payable_entities_on_channel_id"
    t.index ["chart_id"], name: "index_financial_payable_entities_on_chart_id"
    t.index ["date_id"], name: "index_financial_payable_entities_on_date_id"
    t.index ["due_date"], name: "index_financial_payable_entities_on_due_date"
    t.index ["med_id"], name: "index_financial_payable_entities_on_med_id"
    t.index ["method"], name: "index_financial_payable_entities_on_method"
    t.index ["paid"], name: "index_financial_payable_entities_on_paid"
    t.index ["provider_id"], name: "index_financial_payable_entities_on_provider_id"
    t.index ["recurring"], name: "index_financial_payable_entities_on_recurring"
    t.index ["splited"], name: "index_financial_payable_entities_on_splited"
    t.index ["token"], name: "index_financial_payable_entities_on_token"
  end

  create_table "financial_payable_providers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.string "name"
    t.string "id_number"
    t.integer "id_type"
    t.bigint "record_id"
    t.string "record_type"
    t.index ["active"], name: "index_financial_payable_providers_on_active"
    t.index ["id_number"], name: "index_financial_payable_providers_on_id_number"
    t.index ["id_type"], name: "index_financial_payable_providers_on_id_type"
    t.index ["record_id"], name: "index_financial_payable_providers_on_record_id"
    t.index ["record_type"], name: "index_financial_payable_providers_on_record_type"
  end

  create_table "financial_setting_channels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "chart_id"
    t.bigint "med_id"
    t.string "name"
    t.integer "kind"
    t.index ["active"], name: "index_financial_setting_channels_on_active"
    t.index ["kind"], name: "index_financial_setting_channels_on_kind"
  end

  create_table "financial_setting_chart_accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.string "code"
    t.string "name"
    t.integer "master_name"
    t.integer "group"
    t.integer "master_group"
    t.integer "master"
    t.string "chart_name"
    t.string "chart_account"
    t.string "accounting"
    t.string "token"
    t.decimal "deductibility", precision: 15, scale: 2, default: "0.0"
    t.index ["active"], name: "index_financial_setting_chart_accounts_on_active"
    t.index ["chart_name"], name: "index_financial_setting_chart_accounts_on_chart_name"
    t.index ["token"], name: "index_financial_setting_chart_accounts_on_token"
  end

  create_table "financial_statement_transactions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "date_id"
    t.bigint "med_id"
    t.bigint "party_id"
    t.string "party_type"
    t.bigint "channel_id"
    t.bigint "from_id"
    t.bigint "to_id"
    t.string "from_master_name"
    t.string "from_group"
    t.string "from_master_group"
    t.string "from_master"
    t.string "to_master_name"
    t.string "to_group"
    t.string "to_master_group"
    t.string "to_master"
    t.decimal "amount", precision: 15, scale: 2
    t.decimal "from_amount", precision: 15, scale: 2
    t.decimal "to_amount", precision: 15, scale: 2
    t.datetime "date"
    t.string "description"
    t.integer "method"
    t.string "channel_name"
    t.boolean "recurring", default: false
    t.integer "installment"
    t.string "token_tree"
    t.index ["active"], name: "index_financial_statement_transactions_on_active"
    t.index ["channel_id"], name: "index_financial_statement_transactions_on_channel_id"
    t.index ["date_id"], name: "index_financial_statement_transactions_on_date_id"
    t.index ["from_group"], name: "index_financial_statement_transactions_on_from_group"
    t.index ["from_id"], name: "index_financial_statement_transactions_on_from_id"
    t.index ["from_master"], name: "index_financial_statement_transactions_on_from_master"
    t.index ["from_master_group"], name: "index_financial_statement_transactions_on_from_master_group"
    t.index ["from_master_name"], name: "index_financial_statement_transactions_on_from_master_name"
    t.index ["med_id"], name: "index_financial_statement_transactions_on_med_id"
    t.index ["method"], name: "index_financial_statement_transactions_on_method"
    t.index ["party_id"], name: "index_financial_statement_transactions_on_party_id"
    t.index ["party_type"], name: "index_financial_statement_transactions_on_party_type"
    t.index ["recurring"], name: "index_financial_statement_transactions_on_recurring"
    t.index ["to_group"], name: "index_financial_statement_transactions_on_to_group"
    t.index ["to_id"], name: "index_financial_statement_transactions_on_to_id"
    t.index ["to_master"], name: "index_financial_statement_transactions_on_to_master"
    t.index ["to_master_group"], name: "index_financial_statement_transactions_on_to_master_group"
    t.index ["to_master_name"], name: "index_financial_statement_transactions_on_to_master_name"
    t.index ["token_tree"], name: "index_financial_statement_transactions_on_token_tree"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "mail_mkt_bases", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.json "payload"
  end

  create_table "operation_product_booking_calculations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "value"
  end

  create_table "operation_product_bookings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "operation_product_tax_returns", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "product_dates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "product_id"
    t.boolean "open"
    t.integer "month"
    t.integer "year"
    t.string "uniq_product_date"
    t.index ["active"], name: "index_product_dates_on_active"
    t.index ["month"], name: "index_product_dates_on_month"
    t.index ["open"], name: "index_product_dates_on_open"
    t.index ["product_id"], name: "index_product_dates_on_product_id"
    t.index ["uniq_product_date"], name: "index_product_dates_on_uniq_product_date", unique: true
    t.index ["year"], name: "index_product_dates_on_year"
  end

  create_table "product_entities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.boolean "blocked"
    t.bigint "account_id"
    t.bigint "company_id"
    t.integer "name"
    t.integer "kind"
    t.string "uniq_product"
    t.decimal "amount"
    t.date "started_at"
    t.integer "month_started_at"
    t.integer "year_started_at"
    t.text "notes"
    t.integer "status"
    t.string "slug"
    t.index ["account_id"], name: "index_product_entities_on_account_id"
    t.index ["active"], name: "index_product_entities_on_active"
    t.index ["company_id"], name: "index_product_entities_on_company_id"
    t.index ["kind"], name: "index_product_entities_on_kind"
    t.index ["name"], name: "index_product_entities_on_name"
    t.index ["slug"], name: "index_product_entities_on_slug", unique: true
    t.index ["uniq_product"], name: "index_product_entities_on_uniq_product", unique: true
  end

  create_table "user_account_entities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.string "name"
    t.string "cpf"
    t.index ["active"], name: "index_user_account_entities_on_active"
    t.index ["cpf"], name: "index_user_account_entities_on_cpf"
    t.index ["name"], name: "index_user_account_entities_on_name"
  end

  create_table "user_company_entities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.string "name"
    t.string "trade_name"
    t.string "cnpj"
    t.string "kind", array: true
    t.string "subkind", array: true
    t.string "slug"
    t.string "token"
    t.date "opened_at"
    t.text "notes"
    t.index ["active"], name: "index_user_company_entities_on_active"
    t.index ["cnpj"], name: "index_user_company_entities_on_cnpj", unique: true
    t.index ["kind"], name: "index_user_company_entities_on_kind"
    t.index ["name"], name: "index_user_company_entities_on_name"
    t.index ["slug"], name: "index_user_company_entities_on_slug", unique: true
    t.index ["subkind"], name: "index_user_company_entities_on_subkind"
    t.index ["token"], name: "index_user_company_entities_on_token", unique: true
  end

  create_table "user_work_activity_tickets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "board_id"
    t.string "board_type"
    t.string "board_name"
    t.bigint "date_id"
    t.string "date_type"
    t.bigint "owner_id"
    t.string "owner_name"
    t.bigint "performer_id"
    t.string "performer_name"
    t.string "body"
    t.date "started_at"
    t.date "due_at"
    t.datetime "finished_at"
    t.integer "duration"
    t.integer "stage"
    t.integer "status"
    t.integer "flag"
    t.integer "term"
    t.integer "sharing"
    t.integer "priority"
    t.integer "span"
    t.integer "kind"
    t.index ["active"], name: "index_user_work_activity_tickets_on_active"
    t.index ["board_id"], name: "index_user_work_activity_tickets_on_board_id"
    t.index ["board_type"], name: "index_user_work_activity_tickets_on_board_type"
    t.index ["date_id"], name: "index_user_work_activity_tickets_on_date_id"
    t.index ["date_type"], name: "index_user_work_activity_tickets_on_date_type"
    t.index ["due_at"], name: "index_user_work_activity_tickets_on_due_at"
    t.index ["duration"], name: "index_user_work_activity_tickets_on_duration"
    t.index ["flag"], name: "index_user_work_activity_tickets_on_flag"
    t.index ["kind"], name: "index_user_work_activity_tickets_on_kind"
    t.index ["owner_id"], name: "index_user_work_activity_tickets_on_owner_id"
    t.index ["performer_id"], name: "index_user_work_activity_tickets_on_performer_id"
    t.index ["priority"], name: "index_user_work_activity_tickets_on_priority"
    t.index ["sharing"], name: "index_user_work_activity_tickets_on_sharing"
    t.index ["span"], name: "index_user_work_activity_tickets_on_span"
    t.index ["stage"], name: "index_user_work_activity_tickets_on_stage"
    t.index ["started_at"], name: "index_user_work_activity_tickets_on_started_at"
    t.index ["status"], name: "index_user_work_activity_tickets_on_status"
    t.index ["term"], name: "index_user_work_activity_tickets_on_term"
  end

  create_table "user_work_tracker_journeys", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "project_id"
    t.string "results"
    t.datetime "date"
    t.index ["active"], name: "index_user_work_tracker_journeys_on_active"
    t.index ["date"], name: "index_user_work_tracker_journeys_on_date"
    t.index ["project_id"], name: "index_user_work_tracker_journeys_on_project_id"
  end

  create_table "user_work_tracker_projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.string "name"
    t.string "token"
    t.string "slug"
    t.string "description"
    t.datetime "started_at"
    t.integer "unit"
    t.integer "status"
    t.integer "total_tickets", default: 0
    t.integer "total_resolved", default: 0
    t.integer "total_canceled", default: 0
    t.integer "total_delays", default: 0
    t.integer "total_in_process", default: 0
    t.integer "total_comments", default: 0
    t.integer "total_squads", default: 0
    t.integer "total_stories", default: 0
    t.index ["slug"], name: "index_user_work_tracker_projects_on_slug", unique: true
    t.index ["status"], name: "index_user_work_tracker_projects_on_status"
    t.index ["token"], name: "index_user_work_tracker_projects_on_token", unique: true
    t.index ["unit"], name: "index_user_work_tracker_projects_on_unit"
  end

  create_table "user_work_tracker_relations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "dependent_id"
    t.bigint "precedent_id"
    t.string "name"
    t.string "dependent_slug"
    t.string "precedent_slug"
    t.string "token"
    t.boolean "status", default: false
    t.index ["dependent_id"], name: "index_user_work_tracker_relations_on_dependent_id"
    t.index ["dependent_slug"], name: "index_user_work_tracker_relations_on_dependent_slug"
    t.index ["precedent_id"], name: "index_user_work_tracker_relations_on_precedent_id"
    t.index ["precedent_slug"], name: "index_user_work_tracker_relations_on_precedent_slug"
    t.index ["status"], name: "index_user_work_tracker_relations_on_status"
    t.index ["token"], name: "index_user_work_tracker_relations_on_token", unique: true
  end

  create_table "user_work_tracker_squads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "project_id"
    t.bigint "team_id"
    t.string "team_name"
    t.string "token"
    t.integer "role"
    t.integer "total_tickets", default: 0
    t.integer "total_comments", default: 0
    t.integer "total_delays", default: 0
    t.integer "total_in_process", default: 0
    t.index ["project_id"], name: "index_user_work_tracker_squads_on_project_id"
    t.index ["role"], name: "index_user_work_tracker_squads_on_role"
    t.index ["team_id"], name: "index_user_work_tracker_squads_on_team_id"
    t.index ["token"], name: "index_user_work_tracker_squads_on_token", unique: true
  end

  create_table "user_work_tracker_stories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "project_id"
    t.string "name"
    t.string "description"
    t.string "token"
    t.string "slug"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer "stage"
    t.integer "status"
    t.integer "total_tickets", default: 0
    t.integer "total_resolved", default: 0
    t.integer "total_canceled", default: 0
    t.integer "total_delays", default: 0
    t.integer "total_in_process", default: 0
    t.integer "total_comments", default: 0
    t.integer "total_dependents", default: 0
    t.integer "total_precedents", default: 0
    t.index ["finished_at"], name: "index_user_work_tracker_stories_on_finished_at"
    t.index ["project_id"], name: "index_user_work_tracker_stories_on_project_id"
    t.index ["slug"], name: "index_user_work_tracker_stories_on_slug", unique: true
    t.index ["stage"], name: "index_user_work_tracker_stories_on_stage"
    t.index ["started_at"], name: "index_user_work_tracker_stories_on_started_at"
    t.index ["status"], name: "index_user_work_tracker_stories_on_status"
    t.index ["token"], name: "index_user_work_tracker_stories_on_token", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "account_id"
    t.string "name"
    t.string "cpf"
    t.index ["active"], name: "index_users_on_active"
    t.index ["cpf"], name: "index_users_on_cpf"
  end

  add_foreign_key "commercial_calculations", "commercial_dates", column: "date_id"
  add_foreign_key "commercial_sales_leads_entities", "commercial_dates", column: "date_id"
  add_foreign_key "commercial_sales_leads_sources", "commercial_sales_leads_entities", column: "lead_id"
  add_foreign_key "commercial_sales_opportunities_entities", "commercial_dates", column: "date_id"
  add_foreign_key "commercial_sales_opportunities_journeys", "commercial_sales_opportunities_entities", column: "opportunity_id"
  add_foreign_key "commercial_sales_opportunities_leads", "commercial_dates", column: "date_id"
  add_foreign_key "commercial_sales_opportunities_leads", "commercial_sales_leads_entities", column: "lead_id"
  add_foreign_key "commercial_sales_opportunities_leads", "commercial_sales_opportunities_entities", column: "opportunity_id"
  add_foreign_key "commercial_sales_opportunities_products", "commercial_dates", column: "date_id"
  add_foreign_key "commercial_sales_opportunities_products", "commercial_sales_opportunities_entities", column: "opportunity_id"
  add_foreign_key "commercial_sales_opportunities_tickets", "commercial_sales_opportunities_entities", column: "opportunity_id"
  add_foreign_key "financial_payable_entities", "financial_config_dates", column: "date_id"
  add_foreign_key "financial_payable_entities", "financial_payable_providers", column: "provider_id"
  add_foreign_key "financial_payable_entities", "financial_setting_channels", column: "channel_id"
  add_foreign_key "financial_payable_entities", "financial_setting_chart_accounts", column: "chart_id"
  add_foreign_key "financial_payable_entities", "user_company_entities", column: "med_id"
  add_foreign_key "financial_setting_channels", "financial_setting_chart_accounts", column: "chart_id"
  add_foreign_key "financial_setting_channels", "user_company_entities", column: "med_id"
  add_foreign_key "financial_statement_transactions", "financial_config_dates", column: "date_id"
  add_foreign_key "financial_statement_transactions", "financial_setting_channels", column: "channel_id"
  add_foreign_key "financial_statement_transactions", "financial_setting_chart_accounts", column: "from_id"
  add_foreign_key "financial_statement_transactions", "financial_setting_chart_accounts", column: "to_id"
  add_foreign_key "financial_statement_transactions", "user_company_entities", column: "med_id"
  add_foreign_key "product_dates", "product_entities", column: "product_id"
  add_foreign_key "product_entities", "user_account_entities", column: "account_id"
  add_foreign_key "product_entities", "user_company_entities", column: "company_id"
  add_foreign_key "user_work_activity_tickets", "user_account_entities", column: "owner_id"
  add_foreign_key "user_work_activity_tickets", "user_account_entities", column: "performer_id"
  add_foreign_key "user_work_tracker_journeys", "user_work_tracker_projects", column: "project_id"
  add_foreign_key "user_work_tracker_relations", "user_work_tracker_stories", column: "dependent_id"
  add_foreign_key "user_work_tracker_relations", "user_work_tracker_stories", column: "precedent_id"
  add_foreign_key "user_work_tracker_squads", "user_account_entities", column: "team_id"
  add_foreign_key "user_work_tracker_squads", "user_work_tracker_projects", column: "project_id"
  add_foreign_key "user_work_tracker_stories", "user_work_tracker_projects", column: "project_id"
  add_foreign_key "users", "user_account_entities", column: "account_id"
end
