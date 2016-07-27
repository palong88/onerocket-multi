class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_tasks_path(:team => params[:category][:team], :category => params[:category][:name]), notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      ap @admin_tasks = AdminTask.where(:category => @category.name)
      ap @eadmin_tasks = EadminTask.where(:category => @category.name)
      if @category.update(category_params)
        @admin_tasks.update_all(:category => @category.name )
        @eadmin_tasks.update_all(:category => @category.name )
        format.html { redirect_to categories_path, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    ap @category.name
    ap @admin_tasks = AdminTask.where(:category => @category.name, :team => @category.team )
    @admin_tasks.destroy_all
    @category.destroy
    # @admin_tasks.destroy(params[:admin_tasks][:id])
    # ap @admin_tasks.where(:category => @category.name)
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :team)
    end
end
