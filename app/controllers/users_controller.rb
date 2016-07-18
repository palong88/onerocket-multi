class UsersController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.all

  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @team = Team.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def eadmin_tasks
    @user = User.find(params[:id])

    my_id_param = params[:id]

    # @paperwork_link = 'Paperwork<span class="badge">'+@user.eadmin_tasks.where(:category => "Paperwork").where(:completed => [nil, 0]).count.to_s+'</span>'
    # @eat_link = 'Equipment &amp; Tools<span class="badge">'+@user.eadmin_tasks.where(:category => "Equipment & Tools").where(:completed => [nil, 0]).count.to_s+'</span>'
    # @mtc_link = 'Meet the Company<span class="badge">'+@user.eadmin_tasks.where(:category => "Meet the Company").where(:completed => [nil, 0]).count.to_s+'</span>'
    # @getgoing_link = 'Get Going<span class="badge">'+@user.eadmin_tasks.where(:category => "Get Going").where(:completed => [nil, 0]).count.to_s+'</span>'
    @categories = Category.where(:team => current_user.user_info)
    @categories_all = Category.where(:team => "All")
    @events = Event.includes(:users).where(users: {id: params[:id]})

    if params[:category]
      @eadmin_tasks = @user.eadmin_tasks.where(:category => params[:category] )
    else
      @eadmin_tasks = @user.eadmin_tasks.where(:category => @categories_all.first.name )
    end

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
      redirect_to users_path, :flash => { :success => 'User was successfully updated.' }
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    ap @eadmin_tasks = EadminTask.where(:user_id => @user.id)
    @eadmin_tasks.destroy_all
    redirect_to users_path, :flash => { :success => 'User was successfully deleted.' }
  end

  def promote_to_admin
    @user = User.find(params[:id])
    @user.promote_to_admin
    redirect_to users_path, notice: "They are now an admin!"
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :user_info, :start_date)
  end
  def eadmin_task_params
    params.require(:eadmin_task).permit(:title, :description, :media, :due_date, :category, :when_due)
  end
end
