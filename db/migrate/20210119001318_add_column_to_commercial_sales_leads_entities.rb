class AddColumnToCommercialSalesLeadsEntities < ActiveRecord::Migration[5.2]
  def change
    add_column :commercial_sales_leads_entities, :email, :string, unique: true
    add_column :commercial_sales_leads_entities, :uniq_phone, :string, unique: true
    add_column :commercial_sales_leads_entities, :prefix, :string
    add_column :commercial_sales_leads_entities, :phone, :string
  end
end
