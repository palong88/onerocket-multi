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

  before_validation :lowercase_values
  validates :email, :presence => true
  validate :email_is_unique, on: :create
  validate :subdomain_is_unique, on: :create
  after_validation :create_tenant
  after_create :create_account
  after_create :tell_stakeholders


  def confirmation_required?
    false
  end

  #used for tasks... will eventually send out an email to the user.
  def send_reminder
    if has_role? :admin                                           # if user is admin
      User.where.not(id: self.id).each do |u|                     # select all other users
        if u.has_three_day_overdue_tasks?                         # if user has task over 3 days old
          NotificationMailer.tattle_tale(self, u).deliver_now
          puts "oh my god, #{u.email} has a task thats 3 days over due!"
        end
      end
    else
      if has_overdue_tasks?
        NotificationMailer.overdue_email(self).deliver_now
        puts "sent email to #{self.email}"
      end
    end
  end

  # Identify if user has outstanding tasks
  def has_overdue_tasks?
    start = self.start_date
    self.eadmin_tasks.where(completed: 0).each do |task|
      difference = task.due_date.to_i   # Get the number of days from start date
      if task.when_due == "Before"
        difference = difference * -1    # if it is "before", multiply it by negative 1
      end
      return true if (start + difference).past? # if task was due in the past, return true.
    end
    return false  # Return false if not
  end

  # Identify if user has outstanding tasks
  def has_three_day_overdue_tasks?
    start = start_date
    eadmin_tasks.where(completed: 0).each do |task|
      difference = task.due_date.to_i   # Get the number of days from start date
      if task.when_due == "Before"
        difference = difference * -1    # if it is "before", multiply it by negative 1
      end
      return true if (start + difference + 3).past? # if task is three days overdue, return true.
    end
    return false  # Return false if not
  end


  private

  def self.with_role(role)
    my_role = Role.find_by_name(role)
    where(:role => my_role)
  end

  def lowercase_values
    self.subdomain.downcase!
  end
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

  def tell_stakeholders
    Stakeholder.all.each do |u|
      NotificationMailer.notify_stakeholder(u, self).deliver_later
    end
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
        user_id: id,
        completed: 0)

      end
    else
      add_role :admin
      id = self.id

      #Paperwork
      AdminTask.create( :title => "Your Contract", :description => "Please view and sign your contract. f you have any issues please contact X at X@yourcompany.com", :when => "Before", :due_date => "5", :category  => "Paperwork" )
      AdminTask.create( :title => "Data Privacy Agreement", :description => "Please view and sign our data privacy agreement.", :when => "Before", :due_date => "5", :category  => "Paperwork" )
      AdminTask.create( :title => "Health Insurance Enrollment Form", :description => "Please fill out this health insurance enrollment form", :when => "Before", :due_date => "5", :category  => "Paperwork")
      AdminTask.create( :title => "Sexual Harassment Policy", :description => "Please read the attached sexual harassment policy.", :when => "Before", :due_date => "5", :category  => "Paperwork")
      AdminTask.create( :title => "Employee Manual", :description => "Please read the attached employee handbook.", :when => "Before", :due_date => "5", :category  => "Paperwork")
      AdminTask.create( :title => "Employee Details Form", :description => "Please fill out the attached employee details form with info about your bank a/c and preferred payment frequency.", :when => "Before", :due_date => "5", :category  => "Paperwork")

      #Equipment & Tools
      AdminTask.create( :title => "Google Apps", :description => "Make sure you've been setup on Google Apps at least a week before your start date. If this has not been organised for you by this time, please contact X at X@ourcompany.com", :when => "Before", :due_date => "5", :category  => "Equipment & Tools" )
      AdminTask.create( :title => "Personal Preferences Survey", :description => "This survey could include questions about laptop/hardware preferences, desk preferences, dietary requirements etc. ", :when => "Before", :due_date => "3", :category  => "Equipment & Tools" )
      AdminTask.create( :title => "Company Chat", :description => "Please join our company chat at the following link:  ", :when => "Before", :due_date => "3", :category  => "Equipment & Tools" )
      AdminTask.create( :title => "Project Management Tool", :description => "Please join our PM tool at the following link: ", :when => "Before", :due_date => "3", :category  => "Equipment & Tools" )
      AdminTask.create( :title => "Perks", :description => "Check out our company perks at the following link:  ", :when => "Before", :due_date => "3", :category  => "Equipment & Tools" )
      AdminTask.create( :title => "Our Wifi Access", :description => "Our wifi password is xxx123", :when => "After", :due_date => "1", :category  => "Equipment & Tools" )

      #Meet the Company
      AdminTask.create( :title => "Tell us about yourself", :description => "This short survey includes short questions such as favourite food, favourite pasttimes etc. Just so the whole team can get to know you better. ", :when => "Before", :due_date => "3", :category  => "Meet the Company" )
      AdminTask.create( :title => "About Our Company", :description => "Read the attached document about our company, our goals and vision for the future. ", :when => "Before", :due_date => "1", :category  => "Meet the Company" )
      AdminTask.create( :title => "The Team", :description => "This document includes details about our team and their roles, so you always know who to contact about a certain issue. ", :when => "Before", :due_date => "1", :category  => "Meet the Company" )
      AdminTask.create( :title => "Everything about working with us", :description => "This document includes all the little details about our company.", :when => "After", :due_date => "1", :category  => "Meet the Company" )

      #Get Going
      AdminTask.create( :title => "Manager Reach Out", :description => "Your manager will reach out to you at least 2 days before you start to discuss your role as part of our team. If they haven't contacted you by then, please email X at X@ourcompany.com.",  :when => "Before", :due_date => "2", :category  => "Get Going" )
      AdminTask.create( :title => "Your First Day Plan", :description => "Please read the attached plan for your first day with us. We want your first day to be as enjoyable as possible. ", :when => "Before", :due_date => "1", :category  => "Get Going" )
      AdminTask.create( :title => "First One to One", :description => "Description:At the end of your first week, you'll have your first one to one meeting with Jack to see how your settling in. If this hasn't been organised for you by then, please email X at X@ourcompany.com.",  :when => "After", :due_date => "5", :category  => "Get Going" )
      AdminTask.create( :title => "Your First Week Survey", :description => "Please fill out the attached survey, we want to learn how to make everybody's first week as enjoyable as possible.", :when => "After", :due_date => "5", :category  => "Get Going" )
      AdminTask.create( :title => "30 Day Performance Review", :description => "After your first month, you'll have a performance review with John to see how everything's going. Please make sure to organise an exact date with John. ", :when => "After", :due_date => "30", :category  => "Get Going" )

    end
  end
end
