class CreateUserAccountEntity < ActiveRecord::Migration[5.2]
  def change
    create_table :user_account_entities do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.string :name
      t.string :cpf
    end

    add_index :user_account_entities, :active
    add_index :user_account_entities, :name
    add_index :user_account_entities, :cpf
  end
end
