class CreateFinancialConfigDates < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_config_dates do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.boolean :open, default: true, null: false
      t.integer :month
      t.integer :year
      t.string :token
    end

    add_index :financial_config_dates, :active
    add_index :financial_config_dates, :open
    add_index :financial_config_dates, :month
    add_index :financial_config_dates, :year
    add_index :financial_config_dates, :token, unique: true
  end
end
