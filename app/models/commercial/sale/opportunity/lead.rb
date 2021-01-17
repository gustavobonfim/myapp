class Commercial::Sale::Opportunity::Lead < ApplicationRecord

  self.table_name = "commercial_sales_opportunities_leads"
  
  # Relations
  belongs_to :date, class_name: "Commercial::Config::Date", foreign_key: "date_id"
  belongs_to :lead, class_name: "Commercial::Sale::Lead::Entity", foreign_key: "lead_id"
  belongs_to :opportunity, class_name: "Commercial::Sale::Opportunity::Entity", foreign_key: "opportunity_id"
  
  # Validations

  # Callbacks
  before_validation :set_lead

  def set_lead
    lead = self.lead.sources.where(active: true).first

    if lead
      self.lead_name = lead.name
      self.lead_email = lead.email
      self.lead_phone = ContactDecorator.new(lead).phone_pretty
      self.lead_council = lead.council
    end
  end
  
end

# create_table "commercial_sales_opportunities_leads", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "date_id"
# t.bigint "lead_id"
# t.bigint "opportunity_id"
# t.string "lead_name"
# t.string "lead_email"
# t.string "lead_phone"
# t.string "lead_council"