class AddColumnReceivedToFinancialReceivableAdjustments < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_receivable_adjustments, :received, :boolean, default: false
    add_index :financial_receivable_adjustments, :received
  end
end
