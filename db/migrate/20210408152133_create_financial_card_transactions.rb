class CreateFinancialCardTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_card_transactions do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :card_id
      t.bigint :bill_id
      t.bigint :provider_id
      t.date :date
      t.date :first_pay
      t.date :last_pay
      t.date :pay_day
      t.date :closing_day
      t.decimal :amount, default: 0, precision: 15, scale: 2
      t.integer :installment
      t.string :quota
      t.string :description
      t.string :chart_name
      t.string :token
      t.string :token_tree
    end

    add_foreign_key :financial_card_transactions, :financial_card_entities, column: :card_id
    add_foreign_key :financial_card_transactions, :financial_card_bills, column: :bill_id
    add_foreign_key :financial_card_transactions, :financial_payable_providers, column: :provider_id
    add_index :financial_card_transactions, :active
    add_index :financial_card_transactions, :card_id
    add_index :financial_card_transactions, :bill_id
    add_index :financial_card_transactions, :provider_id
    add_index :financial_card_transactions, :chart_name
    add_index :financial_card_transactions, :token, unique: true
    add_index :financial_card_transactions, :token_tree
  end
end
