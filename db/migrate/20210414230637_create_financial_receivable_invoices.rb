class CreateFinancialReceivableInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_receivable_invoices do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :contract_id
      t.date :due_date
      t.string :iugu_invoice_id
      t.string :iugu_secure_id
      t.string :iugu_invoice_url
      t.string :subscription_id
      t.string :bank_line
      t.boolean :fines, default: false
      t.boolean :per_day_interest, default: false
      t.boolean :ignore_due_email, default: false
      t.boolean :early_payment_discount, default: false
      t.boolean :paid, default: false
      t.date :paid_at
      t.integer :status
      t.integer :total_amount_cents, default: 0
      t.decimal :total_amount, default: 0, precision: 15, scale: 2
      t.decimal :total_invoice_amount, default: 0, precision: 15, scale: 2
      t.decimal :total_refund_amount, default: 0, precision: 15, scale: 2
      t.decimal :total_discount_amount, default: 0, precision: 15, scale: 2
      t.string :token
      
      
    end

    add_foreign_key :financial_receivable_invoices, :financial_contract_entities, column: :contract_id
    add_index :financial_receivable_invoices, :active
    add_index :financial_receivable_invoices, :contract_id
    add_index :financial_receivable_invoices, :iugu_invoice_id
    add_index :financial_receivable_invoices, :iugu_secure_id
    add_index :financial_receivable_invoices, :subscription_id
    add_index :financial_receivable_invoices, :status
    add_index :financial_receivable_invoices, :paid
    add_index :financial_receivable_invoices, :token, unique: true
  end
end
