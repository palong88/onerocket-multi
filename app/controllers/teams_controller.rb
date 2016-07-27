class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
    @users = User.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to new_category_path(:team => @team.name ), notice: 'Team was successfully created. Please create a Category' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update

    respond_to do |format|
      ap @team.name
      ap @categorys = Category.where(:team => @team.name)
      ap @admin_tasks = AdminTask.where(:team => @team.name)
      ap @eadmin_tasks = EadminTask.where(:team => @team.name)
      ap @users = User.where(:user_info => @team.name)

      if @team.update(team_params)
        ap @team.name
        @admin_tasks.update_all(:team => @team.name )
        @eadmin_tasks.update_all(:team => @team.name )
        @categorys.update_all(:team => @team.name )
        @users.update_all(:user_info => @team.name )


        format.html { redirect_to team_path, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy

    ap @category = Category.where(:team => @team.name)
    ap @admin_tasks = AdminTask.where(:team => @team.name)
    @team.destroy
    @admin_tasks.destroy_all
    @category.destroy_all
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
        params.require(:team).permit(:name)
    end
end
