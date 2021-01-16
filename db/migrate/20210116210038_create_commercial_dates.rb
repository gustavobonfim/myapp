class CreateCommercialDates < ActiveRecord::Migration[5.2]
  def change
    create_table :commercial_dates do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.boolean :open, default: true, null: false
      t.integer :month
      t.integer :year
      t.string :token
    end

    add_index :commercial_dates, :active
    add_index :commercial_dates, :open
    add_index :commercial_dates, :month
    add_index :commercial_dates, :year
    add_index :commercial_dates, :token, unique: true
  end
end
