class CreateCommercialSalesOpportunitiesTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :commercial_sales_opportunities_tickets do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :opportunity_id
      t.string :description
      t.date :due_at
      t.integer :kind
      t.integer :stage
      t.integer :status
      t.integer :flag
    end

    add_foreign_key :commercial_sales_opportunities_tickets, :commercial_sales_opportunities_entities, column: :opportunity_id
    add_index :commercial_sales_opportunities_tickets, :active
    add_index :commercial_sales_opportunities_tickets, :opportunity_id
    add_index :commercial_sales_opportunities_tickets, :kind
    add_index :commercial_sales_opportunities_tickets, :stage
    add_index :commercial_sales_opportunities_tickets, :status
    add_index :commercial_sales_opportunities_tickets, :flag
  end
end
