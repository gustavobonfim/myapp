class AddColumnTakerIdToFinancialReceivableConciliations < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_receivable_conciliations, :taker_id, :bigint
    add_foreign_key :financial_receivable_conciliations, :financial_contract_takers, column: :taker_id
    add_index :financial_receivable_conciliations, :taker_id
  end
end
