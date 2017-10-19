class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.integer :submitter_id, null: false
      t.integer :short_url_id, null: false

      t.timestamps
    end
    add_index :visits, :submitter_id
    add_index :visits, :short_url_id
  end
end
