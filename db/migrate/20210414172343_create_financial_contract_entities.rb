class CreateFinancialContractEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_contract_entities do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      # t.bigint :purchase_id 
      t.bigint :taker_id 
      t.bigint :client_id 
      t.integer :product_name
      t.integer :product_service
      t.integer :product_kind
      t.integer :kind
      t.integer :plan
      t.integer :status
      t.decimal :monthly, precision: 15, scale: 2, default: "0.0"
      t.decimal :yearly, precision: 15, scale: 2, default: "0.0"
      t.decimal :total_amount, precision: 15, scale: 2, default: "0.0"
      t.boolean :prepaid, default: false
      t.integer :due_day
      t.integer :start_month
      t.integer :start_year
      t.date :due_at
      t.date :started_at
      t.date :finished_at
      t.string :finished_description
      t.string :purchase_token
      t.string :token
      t.string :name
    end

    # add_foreign_key :financial_contract_entities, :financial_purchase_entities, column: :purchase_id
    add_foreign_key :financial_contract_entities, :financial_contract_takers, column: :taker_id
    add_foreign_key :financial_contract_entities, :financial_contract_takers, column: :client_id
    add_index :financial_contract_entities, :active
    # add_index :financial_contract_entities, :purchase_id
    add_index :financial_contract_entities, :taker_id
    add_index :financial_contract_entities, :client_id
    add_index :financial_contract_entities, :product_name
    add_index :financial_contract_entities, :product_service
    add_index :financial_contract_entities, :product_kind
    add_index :financial_contract_entities, :kind
    add_index :financial_contract_entities, :plan
    add_index :financial_contract_entities, :status
    add_index :financial_contract_entities, :purchase_token
    add_index :financial_contract_entities, :token, unique: true
    
  end
end
