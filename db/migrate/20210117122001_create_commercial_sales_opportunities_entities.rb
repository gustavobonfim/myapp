class CreateCommercialSalesOpportunitiesEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :commercial_sales_opportunities_entities do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :date_id
      t.bigint :prospector_id
      t.bigint :closer_id
      t.string :name
      t.date :started_at
      t.date :finished_at
      t.integer :total_leads, default: 0
      t.decimal :total_amount, default: 0, precision: 15, scale: 2
      t.decimal :total_gain, default: 0, precision: 15, scale: 2
      t.decimal :total_lost, default: 0, precision: 15, scale: 2
      t.integer :total_tickets, default: 0
      t.integer :total_calls, default: 0
      t.integer :total_contacts, default: 0
      t.integer :total_in_process, default: 0
      t.integer :source
      t.integer :stage
      t.integer :status
      t.boolean :gain, default: false
      t.boolean :lost, default: false
    end

    add_foreign_key :commercial_sales_opportunities_entities, :commercial_dates, column: :date_id
    add_index :commercial_sales_opportunities_entities, :date_id
    add_index :commercial_sales_opportunities_entities, :prospector_id
    add_index :commercial_sales_opportunities_entities, :closer_id
    add_index :commercial_sales_opportunities_entities, :active
    add_index :commercial_sales_opportunities_entities, :status
    add_index :commercial_sales_opportunities_entities, :stage
    add_index :commercial_sales_opportunities_entities, :source
    add_index :commercial_sales_opportunities_entities, :started_at
    add_index :commercial_sales_opportunities_entities, :finished_at
    add_index :commercial_sales_opportunities_entities, :gain
  end
end
