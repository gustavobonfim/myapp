class CreateFinancialReceivableCalculations < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_receivable_calculations do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :date_id
      t.bigint :med_id
      t.decimal :medclinic, default: 0, precision: 15, scale: 2
      t.decimal :medbooking, default: 0, precision: 15, scale: 2
      t.decimal :medfiling, default: 0, precision: 15, scale: 2
      t.decimal :medpayroll, default: 0, precision: 15, scale: 2
      t.decimal :medreceivement, default: 0, precision: 15, scale: 2
      t.decimal :medbiling, default: 0, precision: 15, scale: 2
      t.decimal :medinvestment, default: 0, precision: 15, scale: 2
      t.decimal :medprotection, default: 0, precision: 15, scale: 2
      t.decimal :medconsulting, default: 0, precision: 15, scale: 2
      t.decimal :interests_revenues, default: 0, precision: 15, scale: 2
      t.decimal :exchange_variation_revenues, default: 0, precision: 15, scale: 2
      t.decimal :miscellaneous_revenues, default: 0, precision: 15, scale: 2
      t.decimal :accounting, default: 0, precision: 15, scale: 2
      t.decimal :biling, default: 0, precision: 15, scale: 2
      t.decimal :investment, default: 0, precision: 15, scale: 2
      t.decimal :protection, default: 0, precision: 15, scale: 2
      t.decimal :miscellaneous, default: 0, precision: 15, scale: 2
      t.decimal :financial_revenues, default: 0, precision: 15, scale: 2
      t.decimal :total_amount, default: 0, precision: 15, scale: 2
      t.decimal :total_income_amount, default: 0, precision: 15, scale: 2
      t.decimal :total_refund_amount, default: 0, precision: 15, scale: 2
      t.decimal :total_received_amount, default: 0, precision: 15, scale: 2
      t.decimal :total_income_received_amount, default: 0, precision: 15, scale: 2
      t.decimal :total_refund_received_amount, default: 0, precision: 15, scale: 2
      t.string :token
    end

    add_foreign_key :financial_receivable_calculations, :financial_config_dates, column: :date_id
    add_foreign_key :financial_receivable_calculations, :user_company_entities, column: :med_id
    add_index :financial_receivable_calculations, :active
    add_index :financial_receivable_calculations, :date_id
    add_index :financial_receivable_calculations, :med_id
    add_index :financial_receivable_calculations, :token, unique: true
  end
end
