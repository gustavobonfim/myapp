class CreateFinancialStatementChartAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_statement_chart_accounts do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.string :code
      t.string :name
      t.integer :master_name
      t.integer :group
      t.integer :master_group
      t.integer :master
      t.string :chart_name
      t.string :chart_account
      t.string :accounting
      t.string :token
      t.decimal :deductibility, default: 0, precision: 15, scale: 2
    end

    add_index :financial_statement_chart_accounts, :active
    add_index :financial_statement_chart_accounts, :chart_name
    add_index :financial_statement_chart_accounts, :token
  end
end
