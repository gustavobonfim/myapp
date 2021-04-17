class ChangeStatusColumnFromFinancialReceivableConciliations < ActiveRecord::Migration[5.2]
  def change
    remove_column :financial_receivable_conciliations, :status
    add_column :financial_receivable_conciliations, :status, :integer
    add_index :financial_receivable_conciliations, :status
  end
end
