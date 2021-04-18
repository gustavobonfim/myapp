class Financial::Book::Setting::ChartAccount < ApplicationRecord

  self.table_name = "financial_setting_chart_accounts"
  
  # Relations
  # belongs_to :date, class_name: "Financial::Config::Date", foreign_key: "date_id"
  has_one :channel, class_name: "Financial::Book::Setting::Channel", foreign_key: "chart_id", dependent: :destroy
  
  # Validations
  validates :token, uniqueness: { case_sensitive: false, message: "Já existe uma conta com essa codificação. "  }
  validates :chart_account, uniqueness: { case_sensitive: false, message: "Conta já existe no Plano de Contas. "  }
  validates :chart_name, uniqueness: { case_sensitive: false, message: "Conta já existe no Plano de Contas. "  }
  # validates :name, uniqueness: { case_sensitive: false, message: "Conta já existe no Plano de Contas. "  }
  # validates :accounting, uniqueness: { case_sensitive: false, message: "Plano de Contas Contábil já existe. "  }

  # Enums
  enum kind: { statement: 0, balance: 1 }, _prefix: :_
  
  enum master_name: {
                      :availabilities => 1,
                      :short_term_financial_investments => 2,
                      :clients_receivables => 3,
                      :miscellaneous_credits => 4,
                      :prepaid_expenses => 5,
                      :taxes_to_be_recovered => 6,
                      :contribuition_and_others_to_be_recovered => 7,
                      :mutual_receivable => 8,
                      :fixed_assets => 9,
                      :long_term_financial_investments => 10,
                      :branding_know_how => 11,
                      :staff_payables => 12,
                      :expense_payables => 13,
                      :wage_payables => 14,
                      :labor_obligations_payables => 15,
                      :benefits_payables => 16,
                      :taxes_payables => 17,
                      :fees => 18,
                      :bank_loan => 19,
                      :credit_card => 20,
                      :financing => 21,
                      :partners_refund_payables => 22,
                      :client_reversal_payables => 23,
                      :client_advance_revenues => 24,
                      :mutual_payables => 25,
                      :long_term_bank_loan => 26,
                      :long_term_partner_loan => 27,
                      :convertible_mutual => 28,
                      :liabilities_provision => 29,
                      :capital_stock => 30,
                      :capital_reserves => 31,
                      :profit_reserves => 32,
                      :profit_and_loss => 33,
                      :dividend_distribution => 34,
                      :medclinic => 35,
                      :medbooking => 36,
                      :medfiling => 37,
                      :medpayroll => 38,
                      :medreceivement => 39,
                      :medbiling => 40,
                      :medinvestment => 41,
                      :medprotection => 42,
                      :medmiscellaneous => 43,
                      :interests_revenues => 44,
                      :exchange_variation_revenues => 45,
                      :miscellaneous_revenues => 46,
                      :staff_technology => 47,
                      :staff_accounting => 48,
                      :staff_biling => 49,
                      :staff_investment => 50,
                      :staff_protection => 51,
                      :staff_legal => 52,
                      :staff_customer_success => 53,
                      :infrastructure_technology_expenses => 54,
                      :production_technology_expenses => 55,
                      :accounting_expenses => 56,
                      :investment_expenses => 57,
                      :protection_expenses => 58,
                      :customer_success_expenses => 59,
                      :people_sales => 60,
                      :people_marketing => 61,
                      :prospecting_expenses => 62,
                      :offline_expenses => 63,
                      :online_expenses => 64,
                      :staff_administrative => 65,
                      :staff_board => 66,
                      :location_expenses => 67,
                      :utilities_expenses => 68,
                      :office_expenses => 69,
                      :human_capital_expenses => 70,
                      :staff_general => 71,
                      :bank_expenses => 72,
                      :outsourcing_expenses => 73,
                      :taxes_and_fees_expenses => 74,
                      :new_business_expenses => 75,
                      :benefits_expenses => 76,
                      :maintenance_expenses => 77,
                      :depreciation_expenses => 78,
                      :fines_and_interests_expenses => 79,
                      :financial_taxes_expenses => 80,
                      :exchange_variation_expenses => 81,
                      :losses_realization => 82,
                      :master_name_result => 83,
                      :federal_taxes => 84,
                      :city_taxes => 85,
                    }, _prefix: :_
                      
  enum group: {
                :cash_and_cash_equivalents=>1,
                :receivables=>2,
                :prepaid_expenses_and_taxes=>3,
                :asset_mutual_inside_group=>4,
                :tangible=>5,
                :intagible=>6,
                :payables=>7,
                :labor_and_social_obligations=>8,
                :taxes_and_others_obligations=>9,
                :short_term_financial_obligations=>10,
                :refund_and_reversal_payables=>11,
                :advance_revenues=>12,
                :liability_mutual_inside_group=>13,
                :long_term_financial_obligations=>14,
                :grant_liabilities_provision=>15,
                :grant_capital_stock=>16,
                :reserves=>17,
                :accrued_profit_and_loss=>18,
                :accounting=>19,
                :biling=>20,
                :investment=>21,
                :protection=>22,
                :miscellaneous=>23,
                :financial_revenues=>24,
                :technology_staff_expenses=>25,
                :operation_staff_expenses=>26,
                :technology_expenses=>27,
                :services_expenses=>28,
                :commercial_staff_expenses=>29,
                :sales_expenses=>30,
                :marketing_expenses=>31,
                :administrative_staff_expenses=>32,
                :administrative_expenses=>33,
                :general_staff_expenses=>34,
                :general_expenses=>35,
                :grant_depreciation_expenses=>36,
                :financial_expenses=>37,
                :grant_losses_realization=>38,
                :group_result=>39,
                :taxes_and_contributions=>40
              }, _prefix: :_

  enum master_group: {
                        :current=>1,
                        :non_current=>2,
                        :net_equity=>3,
                        :operation_revenues=>4,
                        :non_operation_revenues=>5,
                        :operating_expenses=>6,
                        :commercial_expenses=>7,
                        :general_and_administrative_expenses=>8,
                        :non_operation_expenses=>9,
                        :master_group_result=>10,
                        :grant_taxes_and_contributions=>11
                      }, _prefix: :_

  enum master: { 
                 asset: 0,
                 liability: 1,
                 revenues: 2,
                 expenses: 3,
                 result: 4,
                 taxes: 5
                }, _prefix: :_

  # Callbacks

  
  
  
end

# create_table "financial_setting_chart_accounts", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.string "code"
# t.string "name"
# t.integer "master_name"
# t.integer "group"
# t.integer "master_group"
# t.integer "master"
# t.integer "kind"
# t.string "chart_name"
# t.string "chart_account"
# t.string "accounting"
# t.string "token"
# t.decimal "deductibility", precision: 15, scale: 2, default: "0.0"