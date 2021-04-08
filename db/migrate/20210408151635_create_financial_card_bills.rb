class CreateFinancialCardBills < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_card_bills do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :card_id
      t.integer :day
      t.integer :month
      t.integer :year
      t.boolean :paid, default: false
      t.integer :invoice
      t.date :due_date
      t.date :closing_date
      t.decimal :balance, default: 0, precision: 15, scale: 2
      t.string :name
      t.string :token
    end

    add_foreign_key :financial_card_bills, :financial_card_entities, column: :card_id
    add_index :financial_card_bills, :active
    add_index :financial_card_bills, :card_id
    add_index :financial_card_bills, :paid
    add_index :financial_card_bills, :invoice
    add_index :financial_card_bills, :due_date
    add_index :financial_card_bills, :closing_date
    add_index :financial_card_bills, :name
    add_index :financial_card_bills, :token, unique: true
  end
end
