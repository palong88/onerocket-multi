class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_mailer_host
  before_filter :populate_teams

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end



  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protected

  def populate_teams
    @teams = Team.all
  end

  def authenticate_inviter!
    unless current_user.has_role? :admin
      redirect_to root_url, :alert => "You are not authorized to access this page."
      return
    end
    super
  end


  def set_mailer_host
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
    $url_host = request.host_with_port

  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :start_date, :subdomain) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :start_date, :subdomain) }
    devise_parameter_sanitizer.for(:new) { |u| u.permit(:name, :email, :password, :current_password, :start_date, :subdomain) }
    devise_parameter_sanitizer.for(:invite)  << :subdomain << :start_date << :name << :user_info
  end


  def current_user_now
    @current_user_now ||= session[:current_user_id] && User.find_by_id(session[:current_user_id]) # Use find_by_id to get nil instead of an error if user doesn't exist
  end
  helper_method :current_user_now #make this method available in views



end
