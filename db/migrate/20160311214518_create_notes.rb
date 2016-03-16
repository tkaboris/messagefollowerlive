class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes, {:id => false} do |t|
      t.integer :id
      t.datetime :created_at
      t.datetime :updated_at
      t.text :content
      t.integer :notable_id
      t.string :notable_type
      t.integer :listener_id

      t.timestamps null: false
    end
  end
end
