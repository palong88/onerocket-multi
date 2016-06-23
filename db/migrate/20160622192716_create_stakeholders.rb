class CreateStakeholders < ActiveRecord::Migration
  def change
    create_table :stakeholders do |t|
      t.string :name
      t.string :email
      t.string :department
      t.text :template

      t.timestamps null: false
    end
  end
end
