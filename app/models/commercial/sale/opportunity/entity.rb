class Commercial::Sale::Opportunity::Entity < ApplicationRecord

  self.table_name = "commercial_sales_opportunities_entities"
  
  # Relations
  belongs_to :date, class_name: "Commercial::Config::Date", foreign_key: "date_id"
  # belongs_to :prospector, class_name: "User::Account::Entity", foreign_key: "prospector_id", optional: true
  # belongs_to :closer, class_name: "User::Account::Entity", foreign_key: "closer_id", optional: true
  has_many :leads, class_name: "Commercial::Sale::Opportunity::Lead", foreign_key: "opportunity_id", dependent: :destroy
  has_many :products, class_name: "Commercial::Sale::Opportunity::Product", foreign_key: "opportunity_id", dependent: :destroy
  
  # Validations
  validates :started_at, presence: { message: "Falta definir a Data de Início. " }

  # Enums
  enum status: { qualification: 0, booking: 1, meeting: 2, proposal: 3, gain: 4, lost: 5 }, _prefix: :_
  enum source: { base: 0, referrer: 1, landing: 2, event: 3 }, _prefix: :_

  #Callbacks
  # before_validation :set_name

  def set_name
    leads = self.leads
    products = self.products

    if leads
      leads.each do |lead|
        self.name += "#{lead.name }"
      end
    end

    self.name = self.name.squish!
  end
  
end

# create_table "commercial_sales_opportunities_entities", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "date_id"
# t.bigint "prospector_id"
# t.bigint "closer_id"
# t.string "name"
# t.integer "total_leads"
# t.integer "total_amount"
# t.date "started_at"
# t.date "finished_at"
# t.string "status"
# t.string "source"