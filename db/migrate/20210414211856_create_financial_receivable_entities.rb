class CreateFinancialReceivableEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_receivable_entities do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :date_id
      t.bigint :chart_id
      t.bigint :med_id
      t.bigint :channel_id
      t.bigint :contract_id
      t.string :contract_token
      t.datetime :due_date
      t.datetime :received_date
      t.integer :received_span
      t.decimal :amount, default: 0, precision: 15, scale: 2
      t.string :description
      t.string :chart_account
      t.string :chart_name
      t.string :chart_master_name
      t.string :chart_group
      t.integer :kind
      t.string :channel_name
      t.boolean :received, default: false
      t.boolean :recurring, default: false
      t.string :token
    end

    add_foreign_key :financial_receivable_entities, :financial_config_dates, column: :date_id
    add_foreign_key :financial_receivable_entities, :user_company_entities, column: :med_id
    add_foreign_key :financial_receivable_entities, :financial_setting_chart_accounts, column: :chart_id
    add_foreign_key :financial_receivable_entities, :financial_contract_entities, column: :contract_id
    add_foreign_key :financial_receivable_entities, :financial_setting_channels, column: :channel_id
    add_index :financial_receivable_entities, :active
    add_index :financial_receivable_entities, :date_id
    add_index :financial_receivable_entities, :med_id
    add_index :financial_receivable_entities, :chart_id
    add_index :financial_receivable_entities, :contract_id
    add_index :financial_receivable_entities, :channel_id
    add_index :financial_receivable_entities, :kind
    add_index :financial_receivable_entities, :received
    add_index :financial_receivable_entities, :recurring
    add_index :financial_receivable_entities, :due_date
    add_index :financial_receivable_entities, :received_date
    add_index :financial_receivable_entities, :chart_name
    add_index :financial_receivable_entities, :chart_master_name
    add_index :financial_receivable_entities, :chart_group
    add_index :financial_receivable_entities, :token, unique: true
  end
end
