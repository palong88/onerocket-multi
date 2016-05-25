class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :async
         

   validate :email_is_unique, on: :create
   after_create :create_account



   private

   #Email should be unique in the account model
   def email_is_unique
   	#Do Not validate email if errors are already in devise or present.
   	return false unless self.errors[:email].empty?

   	unless Account.find_by_email(email).nil?
   		errors.add(:email, "Email is already in use")
   	end
   end
   #Creates accounta after new user account
   #Saves users email to account model
   def create_account
      account = Account.new(:email => email)
      account.save!
   end



end
