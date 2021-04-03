class CreateFinancialSettingTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_setting_transactions do |t|
    t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :date_id
      t.bigint :chart_id
      t.bigint :med_id
      t.bigint :party_id
      t.string :party_type
      t.bigint :channel_id
      t.bigint :from_id
      t.bigint :to_id
      t.integer :from_master_name
      t.integer :from_group
      t.integer :from_master_group
      t.integer :from_master
      t.integer :to_master_name
      t.integer :to_group
      t.integer :to_master_group
      t.integer :to_master
      t.decimal :amount, precision: 15, scale: 2
      t.decimal :from_amount, precision: 15, scale: 2
      t.decimal :to_amount, precision: 15, scale: 2
      t.datetime :date
      t.string :description
      t.integer :method
      t.string :channel_name
      t.boolean :recurring, default: false
      t.integer :installment
      t.string :token_tree
      
    end

    add_foreign_key :financial_setting_transactions, :financial_setting_chart_accounts, column: :from_id
    add_foreign_key :financial_setting_transactions, :financial_setting_chart_accounts, column: :to_id
    add_foreign_key :financial_setting_transactions, :user_company_entities, column: :med_id
    add_foreign_key :financial_setting_transactions, :financial_setting_channels, column: :channel_id
    add_foreign_key :financial_setting_transactions, :financial_config_dates, column: :date_id
    add_index :financial_setting_transactions, :active
    add_index :financial_setting_transactions, :date_id
    add_index :financial_setting_transactions, :from_id
    add_index :financial_setting_transactions, :to_id
    add_index :financial_setting_transactions, :med_id
    add_index :financial_setting_transactions, :party_id
    add_index :financial_setting_transactions, :party_type
    add_index :financial_setting_transactions, :channel_id
    add_index :financial_setting_transactions, :method
    add_index :financial_setting_transactions, :recurring
    add_index :financial_setting_transactions, :from_master_name
    add_index :financial_setting_transactions, :from_group
    add_index :financial_setting_transactions, :from_master_group
    add_index :financial_setting_transactions, :from_master
    add_index :financial_setting_transactions, :to_master_name
    add_index :financial_setting_transactions, :to_group
    add_index :financial_setting_transactions, :to_master_group
    add_index :financial_setting_transactions, :to_master
    add_index :financial_setting_transactions, :token_tree
  end
end
