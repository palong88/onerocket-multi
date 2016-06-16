module DeviseHelper
  #chacks if current resource has an error
  def devise_error_messages?
    !resource.errors.empty?
  end

end
