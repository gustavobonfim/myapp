class CreateOperationProductBookingCalculation < ActiveRecord::Migration[5.2]
  def change
    create_table :operation_product_booking_calculations do |t|
      t.timestamps
      t.string :value
    end
  end
end
