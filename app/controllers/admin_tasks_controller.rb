class AdminTasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_admin_task, only: [:show, :edit, :update, :destroy]

  # GET /admin_tasks
  # GET /admin_tasks.json
  def index
    @teams = Team.all

    @paperwork_link = 'Paperwork<span class="badge">'+AdminTask.where(:category => "Paperwork").count.to_s+'</span>'
    @eat_link = 'Equipment &amp; Tools<span class="badge">'+AdminTask.where(:category => "Equipment & Tools").count.to_s+'</span>'
    @mtc_link = 'Meet the Company<span class="badge">'+AdminTask.where(:category => "Meet the Company").count.to_s+'</span>'
    @getgoing_link = 'Get Going<span class="badge">'+AdminTask.where(:category => "Get Going").count.to_s+'</span>'


  # This was working the same way before I changed it. No I don;t remember why I changed it  
    if params[:category] && params[:team]
      @admin_tasks = AdminTask.where(:category => params[:category]).where(:team => params[:team])
    elsif params[:team]
      @admin_tasks = AdminTask.where(:category => "Paperwork").where(:team => params[:team])
    elsif params[:category]
      @admin_tasks = AdminTask.where(:category => params[:category])
    else
      @admin_tasks = AdminTask.where(:category => "Paperwork")
    end

  end

  # GET /admin_tasks/1
  # GET /admin_tasks/1.json
  def show
  end

  # GET /admin_tasks/new
  def new
    @admin_task = AdminTask.new
    @team = Team.all
  end

  # GET /admin_tasks/1/edit
  def edit
  end

  # POST /admin_tasks
  # POST /admin_tasks.json
  def create
    @admin_task = AdminTask.new(admin_task_params)

    respond_to do |format|
      if @admin_task.save
        format.html { redirect_to admin_tasks_path(:category =>params[:admin_task][:category]), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @admin_task }
      else

        format.json { render json: @admin_task.errors, status: :unprocessable_entity }
        format.html { redirect_to new_admin_task_path(:category =>params[:admin_task][:category] ), notice: 'Task not Created.'}

      end
    end
  end

  # PATCH/PUT /admin_tasks/1
  # PATCH/PUT /admin_tasks/1.json
  def update

    respond_to do |format|

      if @admin_task.update(admin_task_params)

        format.html { redirect_to admin_tasks_path(:category => params[:admin_task][:category]), notice: 'Task was successfully updated.' }
        # format.json { render :show, status: :ok, location: @admin_task } SHOW REMOVED
      else
        # format.html { render :edit } OLD REDIRECT PATH NO PARAMS
        format.html { redirect_to edit_admin_tasks_path(:category =>params[:admin_task][:category]), notice: 'Task was not updated.' }
        # format.json { render json: @admin_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_tasks/1
  # DELETE /admin_tasks/1.json
  def destroy
    @admin_task.destroy
    respond_to do |format|
      format.html { redirect_to admin_tasks_path(:category =>params[:category]), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_task
      @admin_task = AdminTask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_task_params
      params.require(:admin_task).permit(:title, :description, :media, :due_date, :category, :when, :document, :team)
    end
end
