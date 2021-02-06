class CreateProductEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :product_entities do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.boolean :blocked
      t.bigint :account_id
      t.bigint :company_id
      t.integer :name
      t.integer :kind
      t.string :uniq_product
      t.decimal :amount
      t.date :started_at
      t.integer :month_started_at
      t.integer :year_started_at
      t.text :notes
      t.integer :status
      t.string :slug
    end

    add_foreign_key :product_entities, :user_account_entities, column: :account_id
    add_foreign_key :product_entities, :user_company_entities, column: :company_id
    add_index :product_entities, :active
    add_index :product_entities, :account_id
    add_index :product_entities, :company_id
    add_index :product_entities, :name
    add_index :product_entities, :kind
    add_index :product_entities, :uniq_product, unique: true
    add_index :product_entities, :slug, unique: true
  end
end
