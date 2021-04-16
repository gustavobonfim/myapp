class CreateFinancialReceivableAdjustments < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_receivable_adjustments do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :date_id
      t.bigint :med_id
      t.bigint :contract_id
      t.string :contract_token
      t.datetime :due_date
      t.decimal :amount, default: 0, precision: 15, scale: 2
      t.string :description
      t.integer :kind
      t.string :token
    end

    add_foreign_key :financial_receivable_adjustments, :financial_config_dates, column: :date_id
    add_foreign_key :financial_receivable_adjustments, :user_company_entities, column: :med_id
    add_foreign_key :financial_receivable_adjustments, :financial_contract_entities, column: :contract_id
    add_index :financial_receivable_adjustments, :active
    add_index :financial_receivable_adjustments, :date_id
    add_index :financial_receivable_adjustments, :med_id
    add_index :financial_receivable_adjustments, :contract_id
    add_index :financial_receivable_adjustments, :contract_token
    add_index :financial_receivable_adjustments, :kind
    add_index :financial_receivable_adjustments, :due_date
    add_index :financial_receivable_adjustments, :token, unique: true
  end
end
