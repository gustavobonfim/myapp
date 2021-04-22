class RenameColumnContractIdFromFinancialReceivableInvoices < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :financial_receivable_invoices, :financial_contract_entities
    rename_column :financial_receivable_invoices, :contract_id, :taker_id
    add_foreign_key :financial_receivable_invoices, :financial_contract_takers, column: :taker_id
  end
end
