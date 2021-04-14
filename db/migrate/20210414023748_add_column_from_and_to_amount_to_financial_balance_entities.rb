class AddColumnFromAndToAmountToFinancialBalanceEntities < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_balance_entities, :from_amount, :decimal, precision: 15, scale: 2, default: "0.0"
    add_column :financial_balance_entities, :to_amount, :decimal, precision: 15, scale: 2, default: "0.0"
  end
end
