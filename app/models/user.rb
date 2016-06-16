class User < ActiveRecord::Base
  rolify
  has_many :admin_tasks
  has_many :eadmin_tasks
  belongs_to :role
  #after_create :set_buildings
  after_create :add_role_to_user


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :async

   validates :email, :presence => true
   validate :email_is_unique, on: :create
   validate :subdomain_is_unique, on: :create
   after_validation :create_tenant
   after_create :create_account


   def confirmation_required?
    false
   end





 private

    def self.with_role(role)
         my_role = Role.find_by_name(role)
         where(:role => my_role)
    end


#


 #Email should be unique in the account model
 def email_is_unique
 	#Do Not validate email if errors are already in devise or present.
 	return false unless self.errors[:email].empty?

 	unless Account.find_by_email(email).nil?
 		errors.add(:email, "Email is already in use")
 	end
 end

  #Subdomain should be unique
  def subdomain_is_unique
    if subdomain.present?
      unless Account.find_by_subdomain(subdomain).nil?
        errors.add(:subdomain, "is already used")
      end
    end

    if Apartment::Elevators::Subdomain.excluded_subdomains.include?(subdomain)
      errors.add(:subdomain, "is not a valid subdomain")
    end
  end


   #Creates accounta after new user account
   #Saves users email to account model
   def create_account
      account = Account.new(:email => email, :subdomain => subdomain)
      account.save!
   end

    def create_tenant
      return false unless self.errors.empty?
      #If its a new record, create the tenant
      #For Edits, do not create
      if self.new_record?
        Apartment::Tenant.create(subdomain)
      end
      #Change schema to the tenant
      Apartment::Tenant.switch!(subdomain)
    end

  #Add default role to the user who signs up
  def add_role_to_user
    if created_by_invite?
      #Gives invited Employees default role.
      add_role :registered
      #copies admin task list to new eadmin task list for new inited employees
       id = self.id
        AdminTask.all.each do |default_b|
          eadmin_tasks.create(
            title: default_b.title,
            description: default_b.description,
            media: default_b.media,
            due_date: default_b.due_date,
            when_due: default_b.when,
            category: default_b.category,
            document: default_b.document,
            user_id: id)

        end
    else
      add_role :admin
      id = self.id

        #Meet the Company Before
        AdminTask.create( :title => "About our Company", :description => "Read about our company", :when => "Before", :due_date => "3", :category  => "Meet the Company" )
        AdminTask.create( :title => "Our Visions and Values", :description => "Read about our visions and values", :when => "Before", :due_date => "3", :category  => "Meet the Company" )
        AdminTask.create( :title => "Employee Testimonials", :description => "Check out some of our employee testimonials", :when => "Before", :due_date => "3", :category  => "Meet the Company")

        #Setup Before
        AdminTask.create( :title => "Google Apps", :description => "Make sure you've been setup on Google Apps at least a week before your start date. If this has not been organised for you by this time, please contact X at X@ourcompany.com", :when => "Before", :due_date => "5", :category  => "Equipment & Tools" )
        AdminTask.create( :title => "Personal Preferences Survey", :description => "This survey could include questions about laptop/hardware preferences, desk preferences, dietary requirements etc. ", :when => "Before", :due_date => "3", :category  => "Paperwork" )

        #Setup After
        AdminTask.create( :title => "Team Contact Details", :description => "In the Google doc link below you will find the contact details of all team members. The link is editable by anyone that has it so please add your own. ", :when => "After", :due_date => "1", :category  => "Meet the Company" )
        AdminTask.create( :title => "Github", :description => "Invitation to Github ", :when => "After", :due_date => "1", :category  => "Equipment & Apps" )
        AdminTask.create( :title => "Slack Invite", :description => "Invitation to Slack ", :when => "After", :due_date => "1", :category  => "Equipment & Apps" )
        AdminTask.create( :title => "Our Wifi Access", :description => "Our wifi password is xxx123", :when => "After", :due_date => "1", :category  => "Equipment & Apps" )
        AdminTask.create( :title => "Project Management Tool", :description => "At our company, we use X to manage our projects. Please join our organisation at the link below ", :when => "After", :due_date => "1", :category  => "Equipment & Apps" )

        #Milestones Before & After
        AdminTask.create( :title => "Your First Day Plan", :description => "Please read the attached plan for your first day with us. We want your first day to be as enjoyable as possible. ", :when => "Before", :due_date => "1", :category  => "Get Going" )
        AdminTask.create( :title => "First One to One", :description => "Description:At the end of your first week, you'll have your first one to one meeting with Jack to see how your settling in.",  :when => "After", :due_date => "5", :category  => "Get Going" )
        AdminTask.create( :title => "30 Day Performance Review", :description => "After your first month, you'll have a performance review with John to see how everything's going. Please make sure to organise an exact date with John. ", :when => "After", :due_date => "30", :category  => "Get Going" )

        #Personal Survey/Details Before & After
        AdminTask.create( :title => "Employee Details", :description => "This survey could include questions such as name, address, social media info, etc. (Please remember that this description box is used to communication a message to your employees, so please update this box with your message) ", :when => "Before", :due_date => "1", :category  => "Meet the Company" )
        AdminTask.create( :title => "Data Privacy Agreement", :description => "Please view and sign the attached Data Privacy Agreement", :when => "Before", :due_date => "1", :category  => "Paperwork" )
        AdminTask.create( :title => "Your First Week", :description => "Please fill out the attached survey, we want to make everybody's first week as enjoyable as possible.", :when => "After", :due_date => "5", :category  => "Get Going" )

    end
  end



end
