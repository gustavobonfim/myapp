class ChangeColumnFromCommercialSalesOpportunitiesJourneys < ActiveRecord::Migration[5.2]
  def change
    change_column :commercial_sales_opportunities_journeys, :date, :datetime
  end
end
