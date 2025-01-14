class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :location, null: false
      t.datetime :start_time, null: false
      t.integer :total_tickets, null: false

      t.timestamps
    end
  end
end
