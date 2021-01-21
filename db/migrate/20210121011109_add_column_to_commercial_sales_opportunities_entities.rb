class AddColumnToCommercialSalesOpportunitiesEntities < ActiveRecord::Migration[5.2]
  def change
    add_column :commercial_sales_opportunities_entities, :closer_name, :string
    add_column :commercial_sales_opportunities_entities, :prospector_name, :string
  end
end
