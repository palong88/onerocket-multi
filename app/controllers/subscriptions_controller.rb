class SubscriptionsController < ApplicationController

    skip_before_filter :verify_authenticity_token
    before_action :authenticate_user!
    before_action :authorize_user

    def new
        @plans = Plan.all
    end

    def edit
        @account = Account.find(params[:id])
        @plans   = Plan.all
    end

    def index
        @account = Account.find_by_email(current_user.email)
    end

    #Entry point for showing update card view (the credit card form)
    def update_card
    end

    #Accepts the token parameter from Stripe and updates the credit card on the customer object
    def update_card_details
        #Take the token given by stripe and set it on customer
        token = params[:stripeToken]
        #Get customer_id
        current_account = Account.find_by_email(current_user.email)
        customer_id     = current_account.customer_id

        ap customer_id
        ap token

        #Get customer from Stripe
        customer = Stripe::Customer.retrieve(customer_id)
        #Set new card token
        customer.source = token
        customer.save

        redirect_to edit_user_registration_path, :notice => "Card updated successfully"

        rescue => e
            redirect_to :action => "update_card", :notice => "Card not updated, Please try again."



    end

    def create
        # Get the credit card details submitted by the form
        token           = params[:stripeToken]
        plan            = "One Rocket Plan"
        email           = current_user.email
        current_account = Account.find_by_email(current_user.email)
        customer_id     = current_account.customer_id
        stripe_plan_id  = current_account.stripe_plan_id
        current_plan = current_account.stripe_plan_id
        ap token

        if customer_id.nil?
            #New customer -> Create a customer
            #Create a Customer
            @customer = Stripe::Customer.create(
              :plan   => plan,
              :email  => email,
              :source => token
            )

            subscriptions    = @customer.subscriptions
            @subscribed_plan = subscriptions.data.find{|o| o.plan.id == plan}

        # else
        #     #Customer exists
        #     #Get customer from Stripe
        #     @customer = Stripe::Customer.retrieve(customer_id)
        #     @subscribed_plan = create_or_update_subscription(@customer, current_plan, plan)

        end

        #Get current period end - This is a unix timestamp
        current_period_end = @subscribed_plan.current_period_end
        #Convert to datetime
        active_until = Time.at(current_period_end).to_datetime

        save_account_details(current_account, plan, @customer.id, active_until)
        #redirects to Edit registration account for the user with notice.
        redirect_to edit_user_registration_path, :notice => "Successfully added credit card" #Plan-name

     rescue => e
        redirect_to :back, :notice => "Card not added. Please try again."

    end


    def cancel_subscription
        email           = current_user.email
        current_account = Account.find_by_email(current_user.email)
        customer_id     = current_account.customer_id
        current_plan    = current_account.stripe_plan_id

        #Fetch customer from Stripe
        customer = Stripe::Customer.retrieve(customer_id)
        #Delete it
        customer.delete
        #Update account model
        save_account_details(current_account, nil, nil, Time.at(0).to_datetime)
        ap "saved details"
        ap current_account
        @message = "Card Removed successfully"
        redirect_to edit_user_registration_path, :notice => "Card removed successfully"

    rescue => e
        redirect_to edit_user_registration_path, :flash => {:error => e.message}
    end

    def save_account_details(account, plan, customer_id, active_until)
        #Update Account model
        account.stripe_plan_id = plan
        account.customer_id    = customer_id
        account.active_until   = active_until
        account.save!
    end

    # #Doc
    # def create_or_update_subscription(customer, current_plan, new_plan)
    #     subscriptions = customer.subscriptions
    #
    #     #Get current subscriptions
    #     current_subscription = subscriptions.data.find{ |o| o.plan.id == current_plan }
    #
    #     if current_subscription.blank?
    #         #No current subscription
    #         #Maybe the customer unsubscribed previously or the card was declined
    #         #So, create a new subscription to existing customer
    #         subscription = customer.subscriptions.create({:plan => new_plan })
    #     else
    #         #Existing subscription found
    #         #Must be an upgrade or a downgrade
    #         #So update eistig subscription with new plan
    #         current_subscription.plan = new_plan
    #         subscription = current_subscription.save
    #     end
    #
    #     return subscription
    #
    #
    # end


    #Authorize user or raise exception
    def authorize_user
        authorize! :manage, :subscriptions

    end
end
