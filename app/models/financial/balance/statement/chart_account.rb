class Financial::Balance::Statement::ChartAccount < ApplicationRecord

  self.table_name = "financial_statement_chart_accounts"
  
  # Relations
  # belongs_to :date, class_name: "Financial::Config::Date", foreign_key: "date_id"
  
  # Validations
  validates :token, uniqueness: { case_sensitive: false, message: "Já existe uma conta com essa codificação. "  }
  validates :chart_account, uniqueness: { case_sensitive: false, message: "Conta já existe no Plano de Contas. "  }
  validates :chart_name, uniqueness: { case_sensitive: false, message: "Conta já existe no Plano de Contas. "  }
  # validates :accounting, uniqueness: { case_sensitive: false, message: "Plano de Contas Contábil já existe. "  }

  # Enums
  enum master_name: { 
                      availabilities: 0,
                      short_term_financial_investments: 1,
                      clients: 2,
                      miscellaneous_credits: 3,
                      prepaid_signatures: 4,
                      prepaid_office: 5,
                      prepaid_outsourcing: 6,
                      prepaid_people: 7,
                      prepaid_miscellaneuos: 8,
                      taxes_to_be_recovered: 9,
                      contribuition_and_others_to_be_recovered: 10,
                      receivable_loan: 11,
                      fixed_assets: 12,
                      long_term_financial_investments: 13,
                      branding_know_how: 14,
                      people_payables: 15,
                      expense_payables: 16,
                      people_technology: 17,
                      infrastructure_technology: 18,
                      production_technology: 19,
                      profit_and_loss: 20,
                      master_name_result: 21,
                    }, _prefix: :_
                      
  enum group: { 
                cash_and_cash_equivalents: 0,
                receivables: 1,
                prepaid_expenses: 2,
                taxes_and_contributions_to_be_recovered: 3,
                group_loans: 4,
                tangible: 5,
                intagible: 6,
                payables: 7,
                people_expenses: 7,
                technology_expenses: 8,
                accrued_profit_and_loss: 9,
                group_result: 10
              }, _prefix: :_

  enum master_group: { 
                       current: 0,
                       not_current: 1,
                       net_equity: 2,
                       operating_expenses: 3,
                       master_group_result: 4
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

# create_table "financial_statement_chart_accounts", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.string "code"
# t.string "name"
# t.integer "master_name"
# t.integer "group"
# t.integer "master_group"
# t.integer "master"
# t.string "chart_name"
# t.string "chart_account"
# t.string "accounting"
# t.string "token"
# t.decimal "deductibility", precision: 15, scale: 2, default: "0.0"