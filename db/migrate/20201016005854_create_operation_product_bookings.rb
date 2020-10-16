class CreateOperationProductBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :operation_product_bookings do |t|
      t.timestamps
      t.string :name
    end
  end
end
