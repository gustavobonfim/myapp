class CreateOperationProductTaxReturns < ActiveRecord::Migration[5.2]
  def change
    create_table :operation_product_tax_returns do |t|
      t.timestamps
      t.string :name
    end
  end
end
