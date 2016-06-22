class CreateStakeholders < ActiveRecord::Migration
  def change
    create_table :stakeholders do |t|
      t.string :name
      t.string :email
      t.string :department
      t.text :template
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
