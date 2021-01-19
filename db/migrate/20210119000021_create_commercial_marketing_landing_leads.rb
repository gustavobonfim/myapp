class CreateCommercialMarketingLandingLeads < ActiveRecord::Migration[5.2]
  def change
    create_table :commercial_marketing_landing_leads do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.string :name
      t.string :email
      t.string :ddd
      t.string :number
      t.string :crm
      t.string :crm_state
    end
  end
end
