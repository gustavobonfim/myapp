class CreateOperationOnboardEntities < ActiveRecord::Migration[5.2]
 def change
   create_table :operation_onboard_entities do |t|
     t.timestamps
     t.boolean :active, default: true, null: false
     t.bigint :opportunity_id
     t.bigint :purchase_id
     t.bigint :date_id
     t.integer :product_name
     t.integer :product_kind
     t.integer :product_service
     t.integer :channel
     t.integer :status
     t.integer :kind
     t.boolean :finished, default: false
     t.datetime :finished_at
     t.datetime :started_at
     t.string :journey_status
     t.string :token
     t.string :slug
     t.integer :total_tickets, default: 0
     t.integer :total_comments, default: 0
     t.integer :total_delays, default: 0
     t.integer :total_in_process, default: 0
     t.integer :total_notes, default: 0
     t.integer :total_parties, default: 0
   end
 
   # add_foreign_key :operation_onboard_entities, :sales_opportunities_entities, column: :opportunity_id
   # add_foreign_key :operation_onboard_entities, :financial_purchase_entities, column: :purchase_id
   add_foreign_key :operation_onboard_entities, :operation_onboard_dates, column: :date_id
   add_index :operation_onboard_entities, :opportunity_id
   add_index :operation_onboard_entities, :purchase_id
   add_index :operation_onboard_entities, :date_id
   add_index :operation_onboard_entities, :product_name
   add_index :operation_onboard_entities, :product_kind
   add_index :operation_onboard_entities, :product_service
   add_index :operation_onboard_entities, :channel
   add_index :operation_onboard_entities, :journey_status
   add_index :operation_onboard_entities, :kind
   add_index :operation_onboard_entities, :started_at
   add_index :operation_onboard_entities, :status
   add_index :operation_onboard_entities, :finished
   add_index :operation_onboard_entities, :finished_at
   add_index :operation_onboard_entities, :token, unique: true
   add_index :operation_onboard_entities, :slug, unique: true
 end
end

