class AddTeamToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :team, :string
  end
end
