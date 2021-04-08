class CreateFinancialCardEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_card_entities do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :med_id
      t.integer :pay_day
      t.integer :closing_day
      t.integer :status
      t.string :last_four
      t.string :name
      t.string :token
      t.decimal :credit_limit, default: 0, precision: 15, scale: 2
    end

    add_foreign_key :financial_card_entities, :user_company_entities, column: :med_id
    add_index :financial_card_entities, :active
    add_index :financial_card_entities, :med_id
    add_index :financial_card_entities, :status
    add_index :financial_card_entities, :name
    add_index :financial_card_entities, :token, unique: true
  end
end
