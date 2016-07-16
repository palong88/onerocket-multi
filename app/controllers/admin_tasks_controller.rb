class AdminTasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_admin_task, only: [:show, :edit, :update, :destroy]

  # GET /admin_tasks
  # GET /admin_tasks.json
  def index

    if params[:team] && params[:category]
      ap 'Option 0'
      @teams = Team.all
      @categories = Category.where(:team => params[:team])
      @admin_tasks = AdminTask.where(:team => params[:team], :category => params[:category])
    elsif params[:team]
      ap 'Option 1'
      redirect_to :controller => 'admin_tasks', :action => 'index', :team => params[:team], :category => Category.where(:team => params[:team]).first.name
    else
      ap 'Option 2'
      #  redirect_to admin_task_path()
       redirect_to :controller => 'admin_tasks', :action => 'index', :team => Team.first.name, :category => Category.first.name
      # @categories = Category.where(:team => Category.first.team)
      # @admin_tasks = AdminTask.where(:team => Category.first.team)
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
    ap @admin_task = AdminTask.new(admin_task_params)

    respond_to do |format|
      if @admin_task.save
        format.html { redirect_to admin_tasks_path(:category =>params[:admin_task][:category],:team =>params[:admin_task][:team]), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @admin_task }
      else

        format.json { render json: @admin_task.errors, status: :unprocessable_entity }
        format.html { redirect_to new_admin_task_path(:category =>params[:admin_task][:category],:team =>params[:admin_task][:team] ), notice: 'Task not Created.'}

      end
    end
  end

  # PATCH/PUT /admin_tasks/1
  # PATCH/PUT /admin_tasks/1.json
  def update

    respond_to do |format|

      if @admin_task.update(admin_task_params)

        format.html { redirect_to admin_tasks_path(:category =>params[:admin_task][:category],:team =>params[:admin_task][:team]), notice: 'Task was successfully updated.' }
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
    ap @admin_task
    @admin_task.document = nil
    @admin_task.save
    @admin_task.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Task was successfully deleted.' }
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
