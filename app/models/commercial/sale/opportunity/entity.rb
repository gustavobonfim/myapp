class Commercial::Sale::Opportunity::Entity < ApplicationRecord

  self.table_name = "commercial_sales_opportunities_entities"
  
  # Relations
  belongs_to :date, class_name: "Commercial::Config::Date", foreign_key: "date_id"
  # belongs_to :prospector, class_name: "User::Account::Entity", foreign_key: "prospector_id", optional: true
  # belongs_to :closer, class_name: "User::Account::Entity", foreign_key: "closer_id", optional: true
  has_many :leads, class_name: "Commercial::Sale::Opportunity::Lead", foreign_key: "opportunity_id", dependent: :destroy
  has_many :products, class_name: "Commercial::Sale::Opportunity::Product", foreign_key: "opportunity_id", dependent: :destroy
  has_many :journeys, class_name: "Commercial::Sale::Opportunity::Journey", foreign_key: "opportunity_id", dependent: :destroy
  
  # Validations
  validates :started_at, presence: { message: "Falta definir a Data de Início. " }

  # Enums
  enum stage: { prospecting: 0, qualification: 1, booking: 2, meeting: 3, proposal: 4, closing: 5, gain: 6, lost: 7 }, _prefix: :_
  enum source: { base: 0, referrer: 1, landing: 2, event: 3 }, _prefix: :_
  enum status: { hot: 0, warn: 1, cold: 2 }, _prefix: :_

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
# t.date "started_at"
# t.date "finished_at"
# t.integer "total_leads", default: 0
# t.decimal "total_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_gain", precision: 15, scale: 2, default: "0.0"
# t.integer "total_tickets", default: 0
# t.integer "total_calls", default: 0
# t.integer "total_contacts", default: 0
# t.integer "total_documents", default: 0
# t.integer "source"
# t.integer "stage"
# t.integer "status"
# t.boolean "closed", default: false