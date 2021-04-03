class Financial::Book::Balance::Entity < ApplicationRecord

  self.table_name = "financial_balance_entities"
  
  # Relations
  belongs_to :financial_date, class_name: "Financial::Config::Date", foreign_key: "date_id"
  belongs_to :med, class_name: "User::Company::Entity", foreign_key: "med_id"
  belongs_to :chart, class_name: "Financial::Book::Setting::ChartAccount", foreign_key: "chart_id"
  
  # Validations
  validates :kind, presence: {message: "O tipo de transação não pode ficar em branco. "}

  # Enums
  enum kind: { statement: 0, balance: 1 }, _prefix: :_

  #Callbacks
  before_validation :set_token

  def set_token
    date = self.financial_date

    med_code = self.med_id.to_s(36).rjust(5,"0").upcase
    chart_code = self.chart.code
    year_code = date.year.to_s.rjust(4,"0").upcase
    month_code = date.month.to_s.rjust(2,"0").upcase

    self.token = "#{med_code}#{chart_code}#{year_code}#{month_code}"
  end

end

# create_table "financial_balance_entities", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "date_id"
# t.bigint "med_id"
# t.bigint "chart_id"
# t.integer "kind"
# t.decimal "balance", precision: 15, scale: 2, default: "0.0"
# t.decimal "previous_balance", precision: 15, scale: 2, default: "0.0"
# t.string "chart_name"
# t.string "token"