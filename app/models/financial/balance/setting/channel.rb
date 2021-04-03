class Financial::Balance::Setting::Channel < ApplicationRecord

  self.table_name = "financial_setting_channels"
  
  # Relations
  belongs_to :med, class_name: "User::Company::Entity", foreign_key: "med_id"
  belongs_to :chart, class_name: "Financial::Balance::Setting::ChartAccount", foreign_key: "chart_id"
  
  # Validations
  validates :kind, presence: {message: "O Tipo não pode ficar em Branco. "}
  validates :name, presence: {message: "O Nome não pode ficar em Branco. "},
                   uniqueness: { case_sensitive: false, message: "Canal de Pagamento já existe. "  }

  # Enums
  enum kind: { bank: 0, credit_card: 1 }, _prefix: :_

  # Callbacks
  
  
end

# create_table "financial_setting_channels", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "chart_id"
# t.bigint "med_id"
# t.string "name"
# t.integer "kind"