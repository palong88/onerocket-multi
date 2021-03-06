
class RegistrationsController < Devise::RegistrationsController


  #Overriding Devise's registration controller to check for subdomain
  #Only allow registration if subdomain is absent or is wwww
  def new
    if request.subdomain.blank? || request.subdomain == "signup"
        super
    else
        flash[:notice] = "Access Restricted"
        redirect_to :root
    end

  end

  def edit
    @account = Account.find_by_email(current_user.email)
  end



  protected

  def after_sign_up_path_for(resource)
    #'/an/example/path' # Or :prefix_to_your_route

    new_user_session_url(subdomain: resource.subdomain)

  end





end
