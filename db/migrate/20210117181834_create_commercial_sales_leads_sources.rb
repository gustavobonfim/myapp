class CreateCommercialSalesLeadsSources < ActiveRecord::Migration[5.2]
  def change
    create_table :commercial_sales_leads_sources do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :lead_id
      t.integer :source
      t.bigint :source_id
      t.string :source_type
      t.string :name
      t.string :kind
      t.string :email
      t.string :prefix
      t.string :phone
      t.string :council
    end

    add_foreign_key :commercial_sales_leads_sources, :commercial_sales_leads_entities, column: :lead_id
    add_index :commercial_sales_leads_sources, :active
    add_index :commercial_sales_leads_sources, :lead_id
    add_index :commercial_sales_leads_sources, :source_id
    add_index :commercial_sales_leads_sources, :source_type
    add_index :commercial_sales_leads_sources, :source
    add_index :commercial_sales_leads_sources, :name
    add_index :commercial_sales_leads_sources, :kind
  end
end
