class DevicesController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :new, :index, :create, :show]
  before_action :set_device, only: [:show, :edit, :update, :destroy]
  # GET /devices
  # GET /devices.json
$search = ""    #строка запроса для паджинации в filter_all
$hist= ""	#сохраняем значение филиала в edit и используем в update
########################################################################################
  def filter_all
    if category = params[:search]
	search_filial = category['select_filial']
	search_type = category['select_type']
	search_iswork =  params[:select_iswork]
	search_cancel =  params[:select_cancel]
	search_repair =  params[:select_repair]
	SpecialLog.debug "IP:" + request.remote_ip + "user:" + current_user.name + " Controller: " + self.controller_name + "; View: " +  self.action_name + 	    "param search: filial " + search_filial + "; type " + search_type + "; is work " + search_iswork + "; cancel " + search_cancel
#=begin #*********************************
	arr = []
	if !search_filial.blank? 
	    sel1 = "filial_id = #{search_filial}"
	    arr.push(sel1)
	end
	if !search_type.blank?
	    sel2 =  "type_id = #{search_type}"
	    arr.push(sel2)
	end
	if !search_cancel.blank?
	    sel3 = " cancellation = #{search_cancel}"
	    arr.push(sel3)
	end
	if !search_iswork.blank?
	    sel4 = "iswork = #{search_iswork}"
	    arr.push(sel4)
	end
	if !search_repair.blank?
	    sel5 = "repair = #{search_repair}"
	    arr.push(sel5)
	end
	$search = arr.map do |field|
	    query_string = "#{field}"
	end.join(' AND ')
#=end #*********************************
    end
    @devices = Device.where($search).paginate(page: params[:page], :per_page => 20).order(:type_id)
  end
########################################################################################
  def histories_path

  end
########################################################################################
  def search
    SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name + "; Controller: " + self.controller_name + "; View: " +  self.action_name
  end
########################################################################################
  def index
    if current_user.admin? 
		@fil_options = Filial.all.map{|f| [ f.name, f.id ] }
		@type_options = Type.all.map{|f| [ f.name, f.id ] }
		@devices = Device.all.paginate(page: params[:page], :per_page => 20).order(:filial_id, :type_id)
    else
		@filial = Filial.find(current_user.filial_id)
		fil_id = @filial.id
		@type_options = Type.all.map{|f| [ f.name, f.id ] }
		@devices = @filial.devices.paginate(page: params[:page], :per_page => 20).order(:type_id)
    end
#    SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name + "; Controller: " + self.controller_name + "; View: " +  self.action_name

  end
########################################################################################

  # GET /devices/1
  # GET /devices/1.json
  def show
  end

########################################################################################
  # GET /devices/new
  def new

    SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name
	@fil_options = Filial.all.map{|f| [ f.name, f.id ] }
	@type_options = Type.all.map{|f| [ f.name, f.id ] }
	@device = Device.new
	@fil = Filial.find(current_user.filial_id)

  end
########################################################################################
  # POST /devices
  # POST /devices.json
  def create
    @fil = Filial.find(current_user.filial_id)
    if logged_in? 
        @device = Device.new(device_params)
        respond_to do |format|
	if @device.save
	    SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name + ": dev :" + @device.filial.name + ", " + @device.name
    	    format.html { redirect_to @device, notice: 'Device was successfully created.' }
    	    format.json { render :show, status: :created, location: @device }
        else
    	    format.html { render :new }
    	    format.json { render json: @device.errors, status: :unprocessable_entity }
        end
	end
    end
  end

########################################################################################

  # GET /devices/1/edit
  def edit
    SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name
	@fil_options = Filial.all.map{|f| [ f.name, f.id ] }
	@fil = Filial.find(current_user.filial_id)
	@type_options = Type.all.map{|f| [ f.name, f.id ] }
	if !current_user.admin? && (current_user.filial_id != @device.filial.id )
		flash[:danger] = "  не твой филиал , будь админом" 
		redirect_to devices_path
		return		
	else	

	#    @dev_history = @device.filial.name
		session[:dev_fil] = @device.filial.id
		session[:dev_name] = @device.name
		session[:dev_model] = @device.model
		session[:dev_invnum] = @device.invnum
		session[:dev_serial] = @device.serial
		session[:dev_proc] = @device.proc
		session[:dev_ram] = @device.ram
		session[:dev_place] = @device.place
		session[:dev_cancel] = @device.cancellation
		session[:dev_iswork] = @device.iswork
		session[:dev_repair] = @device.repair
		session[:dev_act] = @device.actimage_file_name
	end
  end

########################################################################################

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
#	@fil_options = Filial.all.map{|f| [ f.name, f.id ] }
#	@type_options = Type.all.map{|f| [ f.name, f.id ] }
	old_fil = session[:dev_fil]
	old_name = session[:dev_name]
	old_model = session[:dev_model]
        old_invnum = session[:dev_invnum]
	old_serial = session[:dev_serial] 
        old_proc = session[:dev_proc] 
        old_ram = session[:dev_ram] 
        old_place = session[:dev_place] 
        old_cancel = session[:dev_cancel]
        old_iswork = session[:dev_iswork] 
        old_repair = session[:dev_repair] 
        old_act = session[:dev_act] 
        #flash[:danger] = "old cancel: #{old_cancel}; new : #{device_params}"
	if old_fil.to_i !=  device_params['filial_id'].to_i
	    old_fil_name = Filial.find(old_fil.to_i).name
    	    @mark = @device.histories.create(mark: "правка: #{current_user.name}; filial: #{old_fil_name}")
	    @mark.save
	end
	if old_name.to_s !=  device_params['name'].to_s
    	    @mark = @device.histories.create(mark: "правка: #{current_user.name}; name: #{old_name}")
	    @mark.save
	end
	if old_model.to_s !=  device_params['model'].to_s
    	    @mark = @device.histories.create(mark: "правка: #{current_user.name}; model: #{old_model}")
	    @mark.save
	end
	if old_invnum.to_s !=  device_params['invnum'].to_s
    	    @mark = @device.histories.create(mark: "правка: #{current_user.name}; inv: #{old_invnum}")
	    @mark.save
	end
	if old_serial.to_s !=  device_params['serial'].to_s
    	    @mark = @device.histories.create(mark: "правка: #{current_user.name}; ser: #{old_serial}")
	    @mark.save
	end
	if old_proc.to_s !=  device_params['proc'].to_s
    	    @mark = @device.histories.create(mark: "правка: #{current_user.name}; proc: #{old_proc}")
	    @mark.save
	end
	if old_ram.to_s !=  device_params['ram'].to_s
    	    @mark = @device.histories.create(mark: "правка: #{current_user.name}; ram: #{old_ram}")
	    @mark.save
	end
	if old_place.to_s !=  device_params['place'].to_s
    	    @mark = @device.histories.create(mark: "правка: #{current_user.name}; place: #{old_place}")
	    @mark.save
	end

	if old_cancel !=  device_params['cancellation'].eql?("1")
    	    @mark = @device.histories.create(mark: "правка: #{current_user.name}; cancel: #{old_cancel}")
	    @mark.save
	end
	if old_iswork !=  device_params['iswork'].eql?("1")
    	    @mark = @device.histories.create(mark: "правка: #{current_user.name}; is work: #{old_iswork}")
	    @mark.save
	end
	if old_repair !=  device_params['repair'].eql?("1")
    	    @mark = @device.histories.create(mark: "правка: #{current_user.name}; repair: #{old_repair}")
	    @mark.save
	end
	dparams = device_params[:actimage]	# читаем объект скана
	if !dparams.nil?
	    accepted_formats = [".gif", ".jpeg", ".png", ".jpg", ".pdf"] #разрешенные форматы файлов
	    checkext = File.extname("#{dparams.original_filename}").downcase #выбираем только расширения с приведением в строчные 
	    permitted = accepted_formats.include? checkext 
	    if accepted_formats.include? checkext
		flash[:danger] = "  #{dparams.original_filename}; #{permitted} " 
	    else
		flash[:danger] = "  не верный формат загружаемого файла! (#{checkext}) ; возможные форматы: #{accepted_formats}" 
		redirect_to edit_device_path
		return
	    end
	end
	    respond_to do |format|
    		if @device.update(device_params)
		    SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name + "; device: " + @device.name + "; invnum: " + @device.invnum
		    if @device.clearact
			@mark = @device.histories.create(mark: "акт ремонта удален filename: #{@device.actimage_file_name} , size: #{@device.actimage_file_size} bytes ")
			@device.actimage = nil
			@device.clearact = false
			@device.repair = false
			@device.save
		    end
			if @device.actimage.exists?
			    @device.update(repair: true)
			    @device.update(iswork: false)
			    if !dparams.nil?
				@mark = @device.histories.create(mark: "акт ремонта прикреплен; filename: #{@device.actimage_file_name} , size: #{@device.actimage_file_size} bytes ")
			    end
			else 
		    	    @device.update(repair: false)
			    @device.update(clearact: false)
			end
    		    format.html { redirect_to @device, notice: 'Описание устройства обновлено.' }
    		    format.json { render :show, status: :ok, location: @device }
    		else
    		    format.html { render :edit }
    		    format.json { render json: @device.errors, status: :unprocessable_entity }
    		end
	    end
#	end
  end

########################################################################################
  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
#    SpecialLog.debug "IP:" + request.remote_ip + " Controller: " + self.controller_name + "; View: " +  self.action_name
    SpecialLog.warn  "IP:" + request.remote_ip + "; user:" + current_user.name  + "; delete Device: " + @device.name + "; filial: " + @device.filial.name + "; invnum: " + @device.invnum
    if logged_in? 
    @device.avatar = nil
    @device.destroy
    respond_to do |format|
      format.html { redirect_to devices_url, notice: 'Оборудование удалено из БД.' }
      format.json { head :no_content }
    end
    end
  end

########################################################################################
########################################################################################

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:name, :model, :invnum, :serial, :dateprod, :proc, :ram, :place, :mark, :cancellation, :iswork, :filial_id, :type_id, :avatar, :actimage, :repair, :clearact, :typeos, :nbname, :brand)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Зарегайся"
        redirect_to login_url
      end
    end

end
