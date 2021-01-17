class CreateCommercialSalesOpportunitiesLeads < ActiveRecord::Migration[5.2]
  def change
    create_table :commercial_sales_opportunities_leads do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :date_id
      t.bigint :lead_id
      t.bigint :opportunity_id
      t.string :lead_name
      t.string :lead_email
      t.string :lead_phone
      t.string :lead_council
    end

    add_foreign_key :commercial_sales_opportunities_leads, :commercial_dates, column: :date_id
    add_foreign_key :commercial_sales_opportunities_leads, :commercial_sales_leads_entities, column: :lead_id
    add_foreign_key :commercial_sales_opportunities_leads, :commercial_sales_opportunities_entities, column: :opportunity_id
    add_index :commercial_sales_opportunities_leads, :date_id
    add_index :commercial_sales_opportunities_leads, :lead_id
    add_index :commercial_sales_opportunities_leads, :opportunity_id
  end
end
