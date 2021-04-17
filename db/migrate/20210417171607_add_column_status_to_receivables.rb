class AddColumnStatusToReceivables < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_receivable_entities, :status, :integer
    add_index :financial_receivable_entities, :status

    add_column :financial_receivable_adjustments, :status, :integer
    add_index :financial_receivable_adjustments, :status

    add_column :financial_contract_takers, :iugu_id, :string
    add_index :financial_contract_takers, :iugu_id

    remove_foreign_key :financial_receivable_conciliations, :financial_receivable_entities
    add_column :financial_receivable_conciliations, :receivable_type, :string
    add_column :financial_receivable_conciliations, :receivable_kind, :integer
    add_index :financial_receivable_conciliations, :receivable_type
    add_index :financial_receivable_conciliations, :receivable_kind

    add_column :financial_receivable_invoices, :total_income_amount, :decimal, default: 0, precision: 15, scale: 2
    add_column :financial_receivable_invoices, :total_reversal_amount, :decimal, default: 0, precision: 15, scale: 2
    add_column :financial_receivable_invoices, :total_error_amount, :decimal, default: 0, precision: 15, scale: 2

  end
end