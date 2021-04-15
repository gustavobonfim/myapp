class AddColumnMethodToFinancialReceivableEntities < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_contract_entities, :method, :integer
    add_index :financial_contract_entities, :method
    add_column :financial_receivable_entities, :method, :integer
    add_index :financial_receivable_entities, :method
  end
end
