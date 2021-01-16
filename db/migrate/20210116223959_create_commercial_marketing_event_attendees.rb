class CreateCommercialMarketingEventAttendees < ActiveRecord::Migration[5.2]
  def change
    create_table :commercial_marketing_event_attendees do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.string :name
      t.string :last_name
      t.string :email
      t.string :ddd
      t.string :number
      t.string :crm
      t.string :crm_state
      t.string :med_school
      t.string :token
      t.string :slug
      t.integer :graduation
      t.integer :kind
    end

    add_index :commercial_marketing_event_attendees, :slug, unique: true
    add_index :commercial_marketing_event_attendees, :token, unique: true
    add_index :commercial_marketing_event_attendees, :email, unique: true
    add_index :commercial_marketing_event_attendees, :active
    add_index :commercial_marketing_event_attendees, :graduation
    add_index :commercial_marketing_event_attendees, :kind
  end
end
