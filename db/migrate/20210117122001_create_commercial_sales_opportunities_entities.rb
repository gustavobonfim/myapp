class CreateCommercialSalesOpportunitiesEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :commercial_sales_opportunities_entities do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :date_id
      t.bigint :prospector_id
      t.bigint :closer_id
      t.string :name
      t.integer :total_leads
      t.integer :total_amount
      t.integer :status
      t.integer :source
      t.date :started_at
      t.date :finished_at
    end

    add_foreign_key :commercial_sales_opportunities_entities, :commercial_dates, column: :date_id
    add_index :commercial_sales_opportunities_entities, :date_id
    add_index :commercial_sales_opportunities_entities, :prospector_id
    add_index :commercial_sales_opportunities_entities, :closer_id
    add_index :commercial_sales_opportunities_entities, :active
    add_index :commercial_sales_opportunities_entities, :status
    add_index :commercial_sales_opportunities_entities, :source
    add_index :commercial_sales_opportunities_entities, :started_at
    add_index :commercial_sales_opportunities_entities, :finished_at
  end
end
