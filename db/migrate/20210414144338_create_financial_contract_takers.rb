class CreateFinancialContractTakers < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_contract_takers do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.string :name
      t.string :id_number
      t.integer :id_type
      t.bigint :record_id 
      t.string :record_type 
    end

    add_index :financial_contract_takers, :active
    add_index :financial_contract_takers, :id_number, unique: true
    add_index :financial_contract_takers, :id_type
    add_index :financial_contract_takers, :record_id
    add_index :financial_contract_takers, :record_type
  end
end
