class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :user, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.string :rsvp

      t.timestamps null: false
    end
    add_index :attendances, ["user_id", "event_id"]
  end
end
