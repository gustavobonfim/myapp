class Financial::Book::Card::Bill < ApplicationRecord

  self.table_name = "financial_card_bills"

  # Storage
  
  # Relations
  belongs_to :card, class_name: "Financial::Book::Card::Entity", foreign_key: "card_id"
  has_many :transactions, class_name: "Financial::Book::Card::Transaction", foreign_key: "card_id", dependent: :destroy

  # Validations
  validates :token, presence: { message: "Os últimos 4 dígitos não pode ficar em branco. " },
                    uniqueness: { message: "Já existe uma fatura para este cartão. " }
  validates :due_date, presence: {message: "O dia de pagamento não pode ficar em branco. "}
  validates :closing_date, presence: {message: "O dia de fechamento não pode ficar em branco. "}

  # Enums
  enum invoice: { open: 0, closed: 1, paid: 2 }, _prefix: :_

  #Callbacks
  before_validation :set_token
  before_validation :set_name

  def set_token
    card_code = self.card_id.to_s.rjust(3,"0").upcase
    year_code = self.year.to_s.rjust(4,"0").upcase
    month_code = self.month.to_s.rjust(2,"0").upcase

    self.token = "#{card_code}#{year_code}#{month_code}"
  end

  def set_name
    month_code = self.month.to_s.rjust(2,"0").upcase
    year_code = self.year.to_s.rjust(4,"0").upcase
    self.name = "Fatura #{self.card.name} | #{month_code}-#{year_code}"
  end

end

# create_table "financial_card_bills", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "card_id"
# t.integer "day"
# t.integer "month"
# t.integer "year"
# t.boolean "paid", default: false
# t.integer "invoice"
# t.date "due_date"
# t.date "closing_date"
# t.decimal "balance", precision: 15, scale: 2, default: "0.0"
# t.string "name"
# t.string "token"