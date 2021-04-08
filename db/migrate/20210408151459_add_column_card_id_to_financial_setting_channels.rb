class AddColumnCardIdToFinancialSettingChannels < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_setting_channels, :card_id, :bigint
    add_foreign_key :financial_setting_channels, :financial_card_entities, column: :card_id
    add_index :financial_setting_channels, :card_id
  end
end
