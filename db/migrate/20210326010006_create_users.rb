class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :account_id
      t.string :name
      t.string :cpf
    end

    add_foreign_key :users, :user_account_entities, column: :account_id
    add_index :users, :active
    add_index :users, :cpf
  end
end
