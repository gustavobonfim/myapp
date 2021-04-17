class AddColumnStatusToReceivables < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_receivable_entities, :status, :integer
    add_index :financial_receivable_entities, :status

    add_column :financial_receivable_adjustments, :status, :integer
    add_index :financial_receivable_adjustments, :status

    add_column :financial_contract_takers, :iugu_id, :string
    add_index :financial_contract_takers, :iugu_id

    add_column :financial_receivable_conciliations, :receivable_type, :string
    add_column :financial_receivable_conciliations, :receivable_kind, :integer
    add_index :financial_receivable_conciliations, :receivable_type
    add_index :financial_receivable_conciliations, :receivable_kind
  end
end