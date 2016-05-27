class SessionsController < Devise::SessionsController
  
  #Overriding Devise's session controller to check for subdomain 
  #Only allow login if subdomain is present and is not www
  def new 
    if request.subdomain.blank? || request.subdomain == "www"
        flash[:notice] = "Access Restricted"
        redirect_to :root
    else
        super
    end

  end  

end