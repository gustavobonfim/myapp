class AddColumnKindToFinancialPayableEntities < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_payable_entities, :kind, :integer
    add_index :financial_payable_entities, :kind
  end
end
