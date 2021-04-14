class AddColumnChannelNameToFinancialCardEntities < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_card_entities, :channel_name, :string
    add_index :financial_card_entities, :channel_name

    add_column :financial_card_entities, :provider_id, :bigint
    add_foreign_key :financial_card_entities, :financial_payable_providers, column: :provider_id
    add_index :financial_card_entities, :provider_id
  end
end
