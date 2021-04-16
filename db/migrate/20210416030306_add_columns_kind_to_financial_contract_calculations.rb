class AddColumnsKindToFinancialContractCalculations < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_contract_calculations, :total_reversal_amount, :decimal, precision: 15, scale: 2, default: "0.0"
    add_column :financial_contract_calculations, :total_error_amount, :decimal, precision: 15, scale: 2, default: "0.0"
    rename_column :financial_contract_calculations, :total_amount, :final_amount

    add_column :financial_receivable_calculations, :total_invoice_amount, :decimal, precision: 15, scale: 2, default: "0.0"
    add_column :financial_receivable_calculations, :total_reversal_amount, :decimal, precision: 15, scale: 2, default: "0.0"
    add_column :financial_receivable_calculations, :total_error_amount, :decimal, precision: 15, scale: 2, default: "0.0"
    rename_column :financial_receivable_calculations, :total_amount, :final_amount
  end
end
