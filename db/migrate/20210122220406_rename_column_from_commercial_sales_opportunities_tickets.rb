class RenameColumnFromCommercialSalesOpportunitiesTickets < ActiveRecord::Migration[5.2]
  def change
    rename_column :commercial_sales_opportunities_tickets, :description, :body
  end
end
