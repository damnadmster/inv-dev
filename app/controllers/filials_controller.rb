class FilialsController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :new, :index, :create, :show]
  before_action :set_filial, only: [:show, :edit, :update, :destroy]


  # GET /filials
  # GET /filials.json
 ########################################################################################
  def exportall_dev
	@devices = Device.all.order( type_id: :asc, filial_id: :asc)
	respond_to do |format|
	  format.html
      format.csv { send_data  @devices.to_csv_new(col_sep: "\t"),  :type => 'charset=iso-8859-1', filename: "All-#{Date.today}.csv" }
	   end
  end
    
 ########################################################################################
  def export_dev
	@fil_id = params[:fil]
	@filial = Filial.find(@fil_id)
	@devices = @filial.devices.all.order(:type_id)
	respond_to do |format|
	  response.headers["Content-Type"] = "text/html; charset=utf-8"
      format.html
      format.csv { send_data  @devices.to_csv_new(col_sep: "\t"),  :type => 'charset=iso-8859-1', filename: "#{@filial.name}-#{Date.today}.csv" }
	 # format.xls { send_data @devices.to_csv_new(col_sep: "\t"),  :type => 'charset=win-1251', filename: "#{@filial.name}-#{Date.today}.xls"  }
    end
  end
  
 ########################################################################################

 def index
    if current_user.admin?
		@filials = Filial.all.order(:name)
    else
		@filials = Filial.find(current_user.filial_id)
    end
#	SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name 
  end

  # GET /filials/1
  # GET /filials/1.json
  def show
  end

  # GET /filials/new
  def new
    if current_user.admin?
	@filial = Filial.new
	SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name 
    else
	flash[:danger] = "Будь админом!"
	redirect_to root_url
    end
  end

  # GET /filials/1/edit
  def edit
	SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name 
  end

  # POST /filials
  # POST /filials.json
  def create
    if current_user.admin?
    @filial = Filial.new(filial_params)
    respond_to do |format|
      if @filial.save
	SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name + "; filial: " + @filial.name
        format.html { redirect_to @filial, notice: 'Filial was successfully created.' }
        format.json { render :show, status: :created, location: @filial }
      else
        format.html { render :new }
        format.json { render json: @filial.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # PATCH/PUT /filials/1
  # PATCH/PUT /filials/1.json
  def update
    respond_to do |format|
      if @filial.update(filial_params)
	SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name  + "; filial: " + @filial.name
        format.html { redirect_to @filial, notice: 'Filial was successfully updated.' }
        format.json { render :show, status: :ok, location: @filial }
      else
        format.html { render :edit }
        format.json { render json: @filial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filials/1
  # DELETE /filials/1.json
  def destroy
    if current_user.admin?
	if @filial.devices.count > 0 
	    respond_to do |format|
    		format.html { redirect_to filials_url, notice: 'В филиале есть оборудование. переместите прежде его' }
    		format.json { head :no_content }
	    end
	else
	    SpecialLog.warn "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name  + "; filial: " + @filial.name
	    @filial.destroy
	    respond_to do |format|
    		format.html { redirect_to filials_url, notice: 'Filial was successfully destroyed.' }
    		format.json { head :no_content }
	    end
	end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filial
      @filial = Filial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def filial_params
      params.require(:filial).permit(:num, :name, :code)
    end

#  before_action :logged_in_user, only: [:edit, :update, :new, :index, :create, :show]
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Зарегайся"
        redirect_to login_url
      end
    end

end
