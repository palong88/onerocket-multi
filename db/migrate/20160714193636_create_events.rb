class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :organizer
      t.string :organizer_email
      t.string :location
      t.date :event_date
      t.references :team, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
