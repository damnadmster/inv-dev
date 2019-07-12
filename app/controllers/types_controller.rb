class TypesController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :new, :index, :create, :show]
  before_action :set_type, only: [:show, :edit, :update, :destroy]

  # GET /types
  # GET /types.json
 ########################################################################################
  def index
#    SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name 
    
	if current_user.admin?
		@types = Type.all.order(:name)
	else
		fil = Filial.find(current_user.filial_id)
		@types = Type.all.order(:name)
	#	@types = Device.where("filial_id = #{fil.id} AND type_id = #{t.id}")
    end
  end
 ########################################################################################
  # GET /types/1
  # GET /types/1.json
  def show
  end
 
 ########################################################################################
  def export_type
	type_id = params[:typeid]
	t = Type.find(type_id)
	if current_user.admin?
		devices = t.devices.all
    else
		fil = Filial.find(current_user.filial_id)
		devices = Device.where("filial_id = #{fil.id} AND type_id = #{t.id}")
    end
	respond_to do |format|
	  response.headers["Content-Type"] = "text/html; charset=utf-8"
      format.html
      format.csv { send_data  devices.to_csv_new(col_sep: "\t"),  :type => 'charset=iso-8859-1', filename: "#{t.name}-#{Date.today}.csv" }
	 # format.xls { send_data @devices.to_csv(col_sep: "\t"),  :type => 'charset=win-1251', filename: "#{@filial.name}-#{Date.today}.xls"  }
    end
  end
 ########################################################################################
  # GET /types/new
  def new
    if current_user.admin?
	@type = Type.new
	SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name 
    else
	flash[:danger] = "Будь админом!"
	redirect_to types_url
    end
  end
 ########################################################################################
  # GET /types/1/edit
  def edit
  end
 ########################################################################################
  # POST /types
  # POST /types.json
  def create
    @type = Type.new(type_params)

    respond_to do |format|
      if @type.save
	SpecialLog.warn "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name + "; type: " + @type.name
        format.html { redirect_to @type, notice: 'Тип оборудования успешно создан.' }
        format.json { render :show, status: :created, location: @type }
      else
        format.html { render :new }
        format.json { render json: @type.errors, status: :unprocessable_entity }
      end
    end
  end
 ########################################################################################
  # PATCH/PUT /types/1
  # PATCH/PUT /types/1.json
  def update
    respond_to do |format|
      if @type.update(type_params)
	SpecialLog.warn "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name + "; type: " + @type.name
        format.html { redirect_to @type, notice: 'Type was successfully updated.' }
        format.json { render :show, status: :ok, location: @type }
      else
        format.html { render :edit }
        format.json { render json: @type.errors, status: :unprocessable_entity }
      end
    end
  end
 ########################################################################################
  # DELETE /types/1
  # DELETE /types/1.json
  def destroy
    if @type.devices.count > 0 
        respond_to do |format|
    		format.html { redirect_to types_url, notice: 'В филиале есть оборудование. переместите прежде его' }
    		format.json { head :no_content }
	end
    else
	SpecialLog.warn "IP:" + request.remote_ip + "; user:" + current_user.name  + "; удаляется тип: " + @type.name
	@type.destroy
	respond_to do |format|
    	    format.html { redirect_to types_url, notice: 'Тип успешно удален.' }
    	    format.json { head :no_content }
	end
    end
  end
 ########################################################################################
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type
      @type = Type.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def type_params
      params.require(:type).permit(:name, :num )
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Зарегайся"
        redirect_to login_url
      end
    end
end
