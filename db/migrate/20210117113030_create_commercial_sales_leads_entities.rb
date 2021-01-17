class CreateCommercialSalesLeadsEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :commercial_sales_leads_entities do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :date_id
      t.string :name
      t.string :council_type
      t.string :council_number
      t.string :council_state
      t.string :council
      t.string :intern_source
      t.string :source_id
      t.string :source_type
      t.string :link
      t.string :email
      t.string :prefix
      t.string :phone
      t.string :token
    end

    add_foreign_key :commercial_sales_leads_entities, :commercial_dates, column: :date_id
    add_index :commercial_sales_leads_entities, :date_id
    add_index :commercial_sales_leads_entities, :active
    add_index :commercial_sales_leads_entities, :intern_source
    add_index :commercial_sales_leads_entities, :source_id
    add_index :commercial_sales_leads_entities, :source_type
    add_index :commercial_sales_leads_entities, :council
    add_index :commercial_sales_leads_entities, :token
  end
end
