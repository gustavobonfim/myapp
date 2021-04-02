class CreateFinancialPayableProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_payable_providers do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.string :name
      t.string :id_number
      t.integer :id_type
      t.bigint :record_id 
      t.string :record_type 
    end

    add_index :financial_payable_providers, :active
    add_index :financial_payable_providers, :id_number
    add_index :financial_payable_providers, :id_type
    add_index :financial_payable_providers, :record_id
    add_index :financial_payable_providers, :record_type
  end
end
