class CreateFinancialStatementChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_statement_channels do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :chart_id
      t.bigint :med_id
      t.string :name
      t.integer :kind
    end

    add_foreign_key :financial_statement_channels, :financial_statement_chart_accounts, column: :chart_id
    add_foreign_key :financial_statement_channels, :user_company_entities, column: :med_id
    add_index :financial_statement_channels, :active
    add_index :financial_statement_channels, :kind
  end
end
