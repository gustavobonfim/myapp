class CreateFinancialContractAdditives < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_contract_additives do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :contract_id
      t.date :date
      t.string :description
      t.decimal :amount, default: 0, precision: 15, scale: 2
      t.integer :kind
    end

    add_foreign_key :financial_contract_additives, :financial_contract_entities, column: :contract_id
    add_index :financial_contract_additives, :active
    add_index :financial_contract_additives, :contract_id
    add_index :financial_contract_additives, :kind

    add_column :financial_contract_calculations, :total_income_received_amount, :decimal, default: 0, precision: 15, scale: 2
    add_column :financial_contract_calculations, :total_refund_received_amount, :decimal, default: 0, precision: 15, scale: 2
    add_column :financial_contract_calculations, :total_discount_received_amount, :decimal, default: 0, precision: 15, scale: 2
    add_column :financial_contract_calculations, :total_reversal_received_amount, :decimal, default: 0, precision: 15, scale: 2
    add_column :financial_contract_calculations, :total_error_received_amount, :decimal, default: 0, precision: 15, scale: 2
    add_column :financial_contract_calculations, :total_invoice_received_amount, :decimal, default: 0, precision: 15, scale: 2
    add_column :financial_contract_calculations, :total_received_amount, :decimal, default: 0, precision: 15, scale: 2
    
    add_column :financial_receivable_calculations, :total_discount_received_amount, :decimal, default: 0, precision: 15, scale: 2
    add_column :financial_receivable_calculations, :total_reversal_received_amount, :decimal, default: 0, precision: 15, scale: 2
    add_column :financial_receivable_calculations, :total_error_received_amount, :decimal, default: 0, precision: 15, scale: 2
    add_column :financial_receivable_calculations, :total_invoice_received_amount, :decimal, default: 0, precision: 15, scale: 2

  end
end
