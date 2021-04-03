class CreateFinancialTransactionEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_transaction_entities do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :date_id
      t.bigint :med_id
      t.bigint :channel_id
      t.bigint :from_id
      t.bigint :to_id
      t.string :from_code
      t.string :from_master_name
      t.string :from_group
      t.string :from_master_group
      t.string :from_master
      t.string :to_code
      t.string :to_master_name
      t.string :to_group
      t.string :to_master_group
      t.string :to_master
      t.decimal :amount, default: 0, precision: 15, scale: 2
      t.decimal :from_amount, default: 0, precision: 15, scale: 2
      t.decimal :to_amount, default: 0, precision: 15, scale: 2
      t.datetime :date
      t.string :description
      t.integer :method
      t.integer :kind
      t.string :channel_name
      t.boolean :recurring, default: false
      t.integer :installment
      t.string :token_tree
      
    end

    add_foreign_key :financial_transaction_entities, :financial_setting_chart_accounts, column: :from_id
    add_foreign_key :financial_transaction_entities, :financial_setting_chart_accounts, column: :to_id
    add_foreign_key :financial_transaction_entities, :user_company_entities, column: :med_id
    add_foreign_key :financial_transaction_entities, :financial_setting_channels, column: :channel_id
    add_foreign_key :financial_transaction_entities, :financial_config_dates, column: :date_id
    add_index :financial_transaction_entities, :active
    add_index :financial_transaction_entities, :date_id
    add_index :financial_transaction_entities, :from_id
    add_index :financial_transaction_entities, :to_id
    add_index :financial_transaction_entities, :med_id
    add_index :financial_transaction_entities, :channel_id
    add_index :financial_transaction_entities, :method
    add_index :financial_transaction_entities, :kind
    add_index :financial_transaction_entities, :recurring
    add_index :financial_transaction_entities, :from_code
    add_index :financial_transaction_entities, :from_master_name
    add_index :financial_transaction_entities, :from_group
    add_index :financial_transaction_entities, :from_master_group
    add_index :financial_transaction_entities, :from_master
    add_index :financial_transaction_entities, :to_code
    add_index :financial_transaction_entities, :to_master_name
    add_index :financial_transaction_entities, :to_group
    add_index :financial_transaction_entities, :to_master_group
    add_index :financial_transaction_entities, :to_master
    add_index :financial_transaction_entities, :token_tree
  end
end
