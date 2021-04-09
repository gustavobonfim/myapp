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

# 65590000020155450015554945443007686000000114000 caju
# 10495966029400010004300002771871285860000141097 condominio
# 75691448710100233290401134740016385880000325694  aluguel
# 00190000090321583700000793382177485850000140000  raphaella
# 23793381286000243215583000050803185950000013900  pluga
# 23791229286000785440392000046901385910000008000 falemais
# 34191096443379369080272046490008685910000082868  alterdata
# 00190000090307580000782898853179185880000026130 iugu
# 34191091072408592293884379810009185910000031907  loggi
# 23793381286000601041154000050804685910000019920  nfeio
# 34191090080806856311672571170009885910000050000  solides
# 846100000013533902962026104150130003000725688709  claro
# 75590003499669145000900600110241785810000008333
# 75590003499669145000900600080246985810000033333 docusign


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