class AddColumnTokenToFinancialPayableCalculations < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_payable_calculations, :token, :string
    add_index :financial_payable_calculations, :token, unique: true
  end
end
