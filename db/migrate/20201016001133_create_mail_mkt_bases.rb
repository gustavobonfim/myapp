class CreateMailMktBases < ActiveRecord::Migration[5.2]
  def change
    create_table :mail_mkt_bases do |t|
      t.timestamps
      t.string :name
      t.json :payload
    end
  end
end
