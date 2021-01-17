class CreateCommercialSalesOpportunitiesJourneys < ActiveRecord::Migration[5.2]
  def change
    create_table :commercial_sales_opportunities_journeys do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :opportunity_id
      t.integer :status
      t.date :date
    end

    add_foreign_key :commercial_sales_opportunities_journeys, :commercial_sales_opportunities_entities, column: :opportunity_id
    add_index :commercial_sales_opportunities_journeys, :active
    add_index :commercial_sales_opportunities_journeys, :opportunity_id
    add_index :commercial_sales_opportunities_journeys, :status
    add_index :commercial_sales_opportunities_journeys, :date
  end
end
