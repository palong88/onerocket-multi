class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all
    @users = User.all

  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    respond_to do |format|
      ap tame_name = params[:document][:team]
      if @document.save
        format.html { redirect_to documents_url(:team_id => @document.team_id, :team => tame_name), notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { redirect_to new_document_path(:team_id => @document.team_id), notice: 'Document not created.' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      ap tame_name = params[:document][:team]
      if @document.update(document_params)
        format.html { redirect_to documents_url(:team_id => @document.team_id, :team =>  tame_name ), notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { redirect_to edit_document_path(:team_id => @document.team_id, :team => params[:team]), notice: 'Document was not updated.'  }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.file = nil
    @document.save
    @document.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Document was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:title, :team_id, :file)
    end
end
