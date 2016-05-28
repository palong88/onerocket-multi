class UsersController < ApplicationController
  
    before_action :authenticate_user!
    #load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

   def eadmin_tasks
    @user = User.find(params[:id])
    my_id_param = params[:id]
    @eadmin_tasks = @user.eadmin_tasks
  end

 

  def create
    @user = User.new(user_params)
    @eadmin_tasks = AdminTask.all
    if @user.save
      redirect_to @user, :flash => { :success => 'Employee was successfully created.' }
    else
      render :action => 'new'
    end
  end


 def new_eadmin
  
    @eadmin_task = current_user.eadmin_tasks.build
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      sign_in(@user, :bypass => true) if @user == current_user
      redirect_to @user, :flash => { :success => 'User was successfully updated.' }
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, :flash => { :success => 'User was successfully deleted.' }
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :start_date)
    end
     def eadmin_task_params
      params.require(:eadmin_task).permit(:title, :description, :media, :due_date, :category, :when_due)
    end
end