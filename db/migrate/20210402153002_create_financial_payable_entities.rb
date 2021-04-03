class CreateFinancialPayableEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_payable_entities do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :date_id
      t.bigint :chart_id
      t.bigint :med_id
      t.bigint :channel_id
      t.bigint :provider_id
      t.string :provider_name
      t.datetime :due_date
      t.datetime :accrual_date
      t.decimal :amount, precision: 15, scale: 2
      t.string :description
      t.string :chart_account
      t.string :chart_name
      t.integer :method
      t.string :channel_name
      t.string :bank_line
      t.boolean :paid, default: false
      t.boolean :recurring, default: false
      t.boolean :splited, default: false
      t.integer :split
      t.integer :installment
      t.string :token
      
    end

    add_foreign_key :financial_payable_entities, :financial_setting_chart_accounts, column: :chart_id
    add_foreign_key :financial_payable_entities, :user_company_entities, column: :med_id
    add_foreign_key :financial_payable_entities, :financial_payable_providers, column: :provider_id
    add_foreign_key :financial_payable_entities, :financial_setting_channels, column: :channel_id
    add_foreign_key :financial_payable_entities, :financial_config_dates, column: :date_id
    add_index :financial_payable_entities, :active
    add_index :financial_payable_entities, :date_id
    add_index :financial_payable_entities, :chart_id
    add_index :financial_payable_entities, :med_id
    add_index :financial_payable_entities, :provider_id
    add_index :financial_payable_entities, :channel_id
    add_index :financial_payable_entities, :method
    add_index :financial_payable_entities, :paid
    add_index :financial_payable_entities, :recurring
    add_index :financial_payable_entities, :splited
    add_index :financial_payable_entities, :token
    add_index :financial_payable_entities, :due_date
    add_index :financial_payable_entities, :accrual_date
  end
end
