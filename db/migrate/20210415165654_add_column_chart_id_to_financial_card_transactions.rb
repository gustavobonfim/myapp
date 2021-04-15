class AddColumnChartIdToFinancialCardTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_card_transactions, :chart_id, :bigint
    add_foreign_key :financial_card_transactions, :financial_setting_chart_accounts, column: :chart_id
    add_index :financial_card_transactions, :chart_id
  end
end
