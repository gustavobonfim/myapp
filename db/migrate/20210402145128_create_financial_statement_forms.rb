class CreateFinancialStatementForms < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_statement_forms do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :chart_id
      t.string :name
      t.integer :kind
    end

    add_foreign_key :financial_statement_forms, :financial_statement_chart_accounts, column: :chart_id
    add_index :financial_statement_forms, :active
    add_index :financial_statement_forms, :kind
  end
end
