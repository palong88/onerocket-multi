class Ability
  include CanCan::Ability

    def initialize(user)
    	user ||= User.new # guest user (not logged in)
		    if user.has_role?(:admin)
		      can :manage, :all
		    else
		      can :read, @eadmin_task
		    end

		   can :manage, :subscriptions if user.has_role? :admin
		   can :manage, :users if user.has_role? :admin
  	end


 
end
