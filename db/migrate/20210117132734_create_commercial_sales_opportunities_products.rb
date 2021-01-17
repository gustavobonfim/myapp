class CreateCommercialSalesOpportunitiesProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :commercial_sales_opportunities_products do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :date_id
      t.bigint :opportunity_id
      t.integer :name
      t.integer :kind
      t.decimal :amount, default: 0, precision: 15, scale: 2
      t.decimal :gain, default: 0, precision: 15, scale: 2
    end

    add_foreign_key :commercial_sales_opportunities_products, :commercial_dates, column: :date_id
    add_foreign_key :commercial_sales_opportunities_products, :commercial_sales_opportunities_entities, column: :opportunity_id
    add_index :commercial_sales_opportunities_products, :date_id
    add_index :commercial_sales_opportunities_products, :opportunity_id
    add_index :commercial_sales_opportunities_products, :active
    add_index :commercial_sales_opportunities_products, :name
    add_index :commercial_sales_opportunities_products, :kind
  end
end
