class UpdateTables < ActiveRecord::Migration

  def up

    team = Team.create(:name => "All")
    team.save

    category = Category.create( :name => "Paperwork", :team => "All")
    category2 = Category.create( :name => "Equipment & Tools", :team => "All")
    category3 = Category.create( :name => "Meet the Company", :team => "All")
    category4 = Category.create( :name => "Get Going", :team => "All")

    category2.save
    category3.save
    category4.save

    AdminTask.update_all(:team => "All")


  end

  def down
    remove_column :users, :status
  end

end
