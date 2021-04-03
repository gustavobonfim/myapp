class CreateFinancialStatementTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_statement_transactions do |t|
    t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :date_id
      t.bigint :med_id
      t.bigint :channel_id
      t.bigint :from_id
      t.bigint :to_id
      t.string :from_master_name
      t.string :from_group
      t.string :from_master_group
      t.string :from_master
      t.string :to_master_name
      t.string :to_group
      t.string :to_master_group
      t.string :to_master
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

    add_foreign_key :financial_statement_transactions, :financial_setting_chart_accounts, column: :from_id
    add_foreign_key :financial_statement_transactions, :financial_setting_chart_accounts, column: :to_id
    add_foreign_key :financial_statement_transactions, :user_company_entities, column: :med_id
    add_foreign_key :financial_statement_transactions, :financial_setting_channels, column: :channel_id
    add_foreign_key :financial_statement_transactions, :financial_config_dates, column: :date_id
    add_index :financial_statement_transactions, :active
    add_index :financial_statement_transactions, :date_id
    add_index :financial_statement_transactions, :from_id
    add_index :financial_statement_transactions, :to_id
    add_index :financial_statement_transactions, :med_id
    add_index :financial_statement_transactions, :channel_id
    add_index :financial_statement_transactions, :method
    add_index :financial_statement_transactions, :recurring
    add_index :financial_statement_transactions, :from_master_name
    add_index :financial_statement_transactions, :from_group
    add_index :financial_statement_transactions, :from_master_group
    add_index :financial_statement_transactions, :from_master
    add_index :financial_statement_transactions, :to_master_name
    add_index :financial_statement_transactions, :to_group
    add_index :financial_statement_transactions, :to_master_group
    add_index :financial_statement_transactions, :to_master
    add_index :financial_statement_transactions, :token_tree
  end
end
