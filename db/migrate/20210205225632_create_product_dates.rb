class CreateProductDates < ActiveRecord::Migration[5.2]
  def change
    create_table :product_dates do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :product_id
      t.boolean :open
      t.integer :month
      t.integer :year
      t.string :uniq_product_date
    end

    add_foreign_key :product_dates, :product_entities, column: :product_id
    add_index :product_dates, :active
    add_index :product_dates, :product_id
    add_index :product_dates, :open
    add_index :product_dates, :month
    add_index :product_dates, :year
    add_index :product_dates, :uniq_product_date, unique: true
  end
end
