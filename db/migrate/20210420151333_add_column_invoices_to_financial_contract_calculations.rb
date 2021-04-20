class AddColumnInvoicesToFinancialContractCalculations < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_contract_calculations, :invoice_token, :string
    add_index :financial_contract_calculations, :invoice_token

    add_column :financial_contract_calculations, :invoice_status, :integer
    add_index :financial_contract_calculations, :invoice_status
  end
end
