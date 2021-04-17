class Financial::Book::Receivable::Conciliation < ApplicationRecord

  self.table_name = "financial_receivable_conciliations"
  
  # Relations
  belongs_to :invoice, class_name: "Financial::Book::Receivable::Invoice", foreign_key: "invoice_id"
  # belongs_to :receivable, class_name: "Financial::Book::Receivable::Receivable", foreign_key: "receivable_id"

  # Validations
  validates :token, presence: {message: "Token de Conciliação de Contas a Receber não pode ficar em branco. "},
                    uniqueness: { case_sensitive: false, message: "Já existe um Conciliador de Contas a Receber com este token. "  }

  # Enums
  enum receivable_kind: { receivable: 0, adjustment: 1 }, _prefix: :_

  #Callbacks
  before_validation :set_token

  def set_token

    receivable_code = self.receivable_id.to_s(36).rjust(5,"0").upcase
    receivable_kind = self.receivable_kind
    invoice_code = self.invoice_id.to_s(36).rjust(5,"0").upcase

    self.token = "#{receivable_kind}-#{receivable_code}#{invoice_code}"
  end
  

end

# create_table "financial_receivable_conciliations", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "invoice_id"
# t.bigint "receivable_id"
# t.string "receivable_type"
# t.integer "receivable_kind"
# t.string "status"
# t.string "token"