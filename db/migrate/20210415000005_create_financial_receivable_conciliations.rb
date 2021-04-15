class CreateFinancialReceivableConciliations < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_receivable_conciliations do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :invoice_id
      t.bigint :receivable_id
      t.string :status
      t.string :token
    end

    add_foreign_key :financial_receivable_conciliations, :financial_receivable_invoices, column: :invoice_id
    add_foreign_key :financial_receivable_conciliations, :financial_receivable_entities, column: :receivable_id
    add_index :financial_receivable_conciliations, :active
    add_index :financial_receivable_conciliations, :invoice_id
    add_index :financial_receivable_conciliations, :receivable_id
    add_index :financial_receivable_conciliations, :status
    add_index :financial_receivable_conciliations, :token, unique: true
  end
end
