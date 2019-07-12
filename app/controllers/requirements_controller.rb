class RequirementsController < ApplicationController
  before_action :set_requirement, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :new, :index, :create, :show]
  # GET /requirements
  # GET /requirements.json
  def index


		@fil_options = Filial.all.map{|f| [ f.name, f.id ] }
		@fil = Filial.find(current_user.filial_id)
		@fil_id = @fil.id
		@requirements = Requirement.paginate(page: params[:page], :per_page => 20).order(:filial_id)

	
  end


  def export_req
	@req = Requirement.all.order( filial_id: :asc, level: :asc)
	respond_to do |format|
	    format.html
    	    format.csv { send_data  @req.to_csv_new(col_sep: "\t"),  :type => 'charset=iso-8859-1', filename: "Req-#{Date.today}.csv" }
	end
  end


  def show
  end

  # GET /requirements/new
  def new
  	
    @requirement = Requirement.new
	    @fil_options = Filial.all.map{|f| [ f.name, f.id ] }
		@fil = Filial.find(current_user.filial_id)
		@fil_id = @fil.id
  end

  # GET /requirements/1/edit
  def edit
			
  		@fil_options = Filial.all.map{|f| [ f.name, f.id ] }
		@fil = Filial.find(current_user.filial_id)
		@fil_id = @fil.id
  end

  # POST /requirements
  # POST /requirements.json
  def create
    @requirement = Requirement.new(requirement_params)
    respond_to do |format|
      if @requirement.save
        format.html { redirect_to @requirement, notice: 'Requirement was successfully created.' }
        format.json { render :show, status: :created, location: @requirement }
      else
        format.html { render :new }
        format.json { render json: @requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requirements/1
  # PATCH/PUT /requirements/1.json
  def update
	SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name 
    respond_to do |format|
      if @requirement.update(requirement_params)
        format.html { redirect_to @requirement, notice: 'Потребность успешно обновлена.' }
        format.json { render :show, status: :ok, location: @requirement }
      else
        format.html { render :edit }
        format.json { render json: @requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requirements/1
  # DELETE /requirements/1.json
  def destroy
  	SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name 
    @requirement.destroy
    respond_to do |format|
      format.html { redirect_to requirements_url, notice: 'Потребность удалена.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requirement
      @requirement = Requirement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def requirement_params
      params.require(:requirement).permit(:wishes, :level, :amount, :price, :link, :for_what, :done, :got, :filial_id)
    end
	
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Зарегайся"
        redirect_to login_url
      end
    end
	
end
