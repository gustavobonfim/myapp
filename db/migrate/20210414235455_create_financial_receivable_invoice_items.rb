class CreateFinancialReceivableInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_receivable_invoice_items do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :invoice_id
      t.string :description
      t.integer :price_cents
      t.integer :quantity
      t.integer :kind
      t.decimal :amount, default: 0, precision: 15, scale: 2

    end

    add_foreign_key :financial_receivable_invoice_items, :financial_receivable_invoices, column: :invoice_id
    add_index :financial_receivable_invoice_items, :active
    add_index :financial_receivable_invoice_items, :invoice_id
    add_index :financial_receivable_invoice_items, :kind
  end
end
