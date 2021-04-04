class CreateFinancialBalanceEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_balance_entities do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :date_id
      t.bigint :med_id
      t.bigint :chart_id
      t.integer :kind
      t.decimal :balance, default: 0, precision: 15, scale: 2
      t.decimal :previous_balance, default: 0, precision: 15, scale: 2
      t.string :chart_name
      t.string :chart_code
      t.string :token
    end

    add_foreign_key :financial_balance_entities, :financial_config_dates, column: :date_id
    add_foreign_key :financial_balance_entities, :user_company_entities, column: :med_id
    add_foreign_key :financial_balance_entities, :financial_setting_chart_accounts, column: :chart_id
    add_index :financial_balance_entities, :active
    add_index :financial_balance_entities, :date_id
    add_index :financial_balance_entities, :chart_id
    add_index :financial_balance_entities, :med_id
    add_index :financial_balance_entities, :kind
    add_index :financial_balance_entities, :chart_name
    add_index :financial_balance_entities, :chart_code
    add_index :financial_balance_entities, :token
  end
end
