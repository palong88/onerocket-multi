
class EadminTasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_eadmin_task, only: [:show, :edit, :update, :destroy]


  # GET /eadmin_tasks
  # GET /eadmin_tasks.json
  def index
    @categories = Category.where(:team => current_user.user_info)
<<<<<<< HEAD
    @categories_all = Category.where(:team => "Everyone")

=======
    @categories_all = Category.where(:team => "All")

    @events = Event.includes(:users).where(users: {id: current_user.id})
    
>>>>>>> events-feature
    if params[:category]
      ap "Option 1"
      @eadmin_tasks = current_user.eadmin_tasks.where( :category => params[:category], :team => params[:team])

    else
      ap "Option 2"
      redirect_to :controller => 'eadmin_tasks', :action => 'index', :category => Category.where(:team => "Everyone").first.name, :team => "Everyone"

    end


    #å
    # @paperwork_link = 'Paperwork<span class="badge">'+current_user.eadmin_tasks.where(:category => "Paperwork").where(:completed => [nil, 0]).count.to_s+'</span>'
    # @eat_link = 'Equipment &amp; Tools<span class="badge">'+current_user.eadmin_tasks.where(:category => "Equipment & Tools").where(:completed => [nil, 0]).count.to_s+'</span>'
    # @mtc_link = 'Meet the Company<span class="badge">'+current_user.eadmin_tasks.where(:category => "Meet the Company").where(:completed => [nil, 0]).count.to_s+'</span>'
    # @getgoing_link = 'Get Going<span class="badge">'+current_user.eadmin_tasks.where(:category => "Get Going").where(:completed => [nil, 0]).count.to_s+'</span>'
    #
    # # @users = User.all
    # #@eadmin_tasks = current_user.eadmin_tasks
    # if params[:category]
    #   @eadmin_tasks = current_user.eadmin_tasks.where(:category => params[:category])
    # else
    #   @eadmin_tasks = current_user.eadmin_tasks.where(:category => "Paperwork")
    # end


  end


  def list
      @users = User.all
  end

  # GET /admin_tasks/1
  # GET /admin_tasks/1.json
  def show
  end

  # GET /admin_tasks/new
  def new
    @eadmin_task = EadminTask.new

  end

  # GET /eadmin_tasks/1/edit
  def edit
  end

  # GET /eadmin_tasks/1/edit
  def complete
     @eadmin_task = EadminTask.find(params[:id])
     @eadmin_task.update_attribute(:completed, 1)

     redirect_to eadmin_tasks_path(:category =>  @eadmin_task.category, :team => @eadmin_task.team), notice: "Task Completed"
  end

  def not_complete
     @eadmin_task = EadminTask.find(params[:id])
     @eadmin_task.update_attribute(:completed, 0)
     redirect_to eadmin_tasks_path(:category =>  @eadmin_task.category, :team => @eadmin_task.team), notice: "Task Not Completed"
  end

  # POST /eadmin_tasks
  # POST /eadmin_tasks.json
  def create


    @eadmin_task = User.find(params[:eadmin_task][:user_id]).eadmin_tasks.build(eadmin_task_params)


    respond_to do |format|
      if @eadmin_task.save
        format.html { redirect_to user_eadmin_tasks_path(:id => params[:eadmin_task][:user_id], :category =>params[:eadmin_task][:category], :team => params[:eadmin_task][:team]), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @eadmin_task }
      else
        format.json { render json: @eadmin_task.errors, status: :unprocessable_entity }
        format.html { redirect_to new_eadmin_task_path(:user_id => params[:eadmin_task][:user_id], :category =>params[:eadmin_task][:category], :team => params[:eadmin_task][:team] ), notice: 'Task was not created.'}

      end
    end
  end

  # PATCH/PUT /admin_tasks/1
  # PATCH/PUT /admin_tasks/1.json
  def update

    respond_to do |format|

      if @eadmin_task.update(eadmin_task_params)


          format.html { redirect_to user_eadmin_tasks_path(:id => params[:eadmin_task][:user_id],:category =>params[:eadmin_task][:category], :team =>params[:eadmin_task][:team]), notice: 'Task was successfully updated.'}
        # format.json { render :show, status: :ok, location: @eadmin_task }
      else
        puts @eadmin_task.errors.full_messages
        format.html { redirect_to edit_eadmin_task_path(@eadmin_task, :id => params[:eadmin_task][:user_id], :category =>params[:eadmin_task][:category] ), notice: 'Task was not created. TEST'}
        # format.json { render json: @eadmin_task.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /admin_tasks/1
  # DELETE /admin_tasks/1.json
  def destroy
    @eadmin_task.destroy
    respond_to do |format|
      #redirect to  :back is depricated in rails 5 so keep note
      format.html { redirect_to :back, notice: 'Task was successfully deleted.' }
      # format.html { redirect_to eadmin_tasks_path(:category =>params[:category]), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_eadmin_task
      @eadmin_task = EadminTask.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def eadmin_task_params
      params.require(:eadmin_task).permit(:user_id, :title, :description, :due_date, :category, :when_due, :document, :team)
    end




end
