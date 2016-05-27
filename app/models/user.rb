class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :async
         

   validate :email_is_unique, on: :create
   validate :subdomain_is_unique, on: :create
   after_validation :create_tenant
   after_create :create_account


   def confirmation_required?
      false
   end



 private

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

   

end
