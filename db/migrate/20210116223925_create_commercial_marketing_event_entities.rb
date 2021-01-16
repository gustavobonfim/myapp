class CreateCommercialMarketingEventEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :commercial_marketing_event_entities do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.string :name
      t.string :title
      t.string :slug
      t.text :description
      t.string :copy
      t.string :meta_title
      t.text :meta_description
      t.string :meta_keywords
      t.string :token
      t.text :notes
      t.integer :sharing
      t.integer :kind
      t.date :date
      t.date :published_at
      t.boolean :published, default: false, null: false
      t.boolean :blocked, default: true, null: false
      t.boolean :finished, default: false, null: false
    end

    add_index :commercial_marketing_event_entities, :slug, unique: true
    add_index :commercial_marketing_event_entities, :token, unique: true
    add_index :commercial_marketing_event_entities, :active
    add_index :commercial_marketing_event_entities, :name
    add_index :commercial_marketing_event_entities, :title
    add_index :commercial_marketing_event_entities, :description
    add_index :commercial_marketing_event_entities, :copy
    add_index :commercial_marketing_event_entities, :meta_title
    add_index :commercial_marketing_event_entities, :meta_description
    add_index :commercial_marketing_event_entities, :meta_keywords
    add_index :commercial_marketing_event_entities, :date
    add_index :commercial_marketing_event_entities, :sharing
    add_index :commercial_marketing_event_entities, :kind
    add_index :commercial_marketing_event_entities, :published
    add_index :commercial_marketing_event_entities, :blocked
    add_index :commercial_marketing_event_entities, :finished
  end
end
