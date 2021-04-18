class AddColumnToReceivableAndContractCalculations < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_contract_calculations, :total_addition_amount, :decimal, default: 0, precision: 15, scale: 2
    add_column :financial_contract_calculations, :total_addition_received_amount, :decimal, default: 0, precision: 15, scale: 2
    add_column :financial_receivable_calculations, :total_addition_amount, :decimal, default: 0, precision: 15, scale: 2
    add_column :financial_receivable_calculations, :total_addition_received_amount, :decimal, default: 0, precision: 15, scale: 2
    add_column :financial_receivable_invoices, :total_addition_amount, :decimal, default: 0, precision: 15, scale: 2
  end
end
