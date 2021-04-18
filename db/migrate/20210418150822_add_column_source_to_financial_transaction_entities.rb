class AddColumnSourceToFinancialTransactionEntities < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_transaction_entities, :source, :integer
    add_index :financial_transaction_entities, :source
  end
end
