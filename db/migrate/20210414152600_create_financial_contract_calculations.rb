class CreateFinancialContractCalculations < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_contract_calculations do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :date_id 
      t.bigint :taker_id
      t.decimal :total_amount, precision: 15, scale: 2, default: "0.0"
      t.decimal :total_income_amount, precision: 15, scale: 2, default: "0.0"
      t.decimal :total_refund_amount, precision: 15, scale: 2, default: "0.0"
      t.decimal :total_discount_amount, precision: 15, scale: 2, default: "0.0"
      t.decimal :total_invoice_amount, precision: 15, scale: 2, default: "0.0"
      t.string :token
    end

    add_foreign_key :financial_contract_calculations, :financial_config_dates, column: :date_id
    add_foreign_key :financial_contract_calculations, :financial_contract_takers, column: :taker_id
    add_index :financial_contract_calculations, :active
    add_index :financial_contract_calculations, :date_id
    add_index :financial_contract_calculations, :taker_id
    add_index :financial_contract_calculations, :token, unique: true
  end
end
