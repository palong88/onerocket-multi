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

    team = Team.find_by(name: "All")
    team.destroy

    category  = Category.where( :name => "Paperwork", :team => "All")
    category2 = Category.where( :name => "Equipment & Tools", :team => "All")
    category3 = Category.where( :name => "Meet the Company", :team => "All")
    category4 = Category.where( :name => "Get Going", :team => "All")

    category.destroy_all
    category2.destroy_all
    category3.destroy_all
    category4.destroy_all

    AdminTask.update_all(:team => nil )

  end

end
