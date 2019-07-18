class RequirementsController < ApplicationController
  before_action :set_requirement, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :new, :index, :create, :show]
  $search_req = ""  
########################################################################################
  # удалить нах с маршрутом
=begin  
  def  filter_req
	   if category = params[:searchreq]
			search_filial = category['select_filial'] 
			search_importance = params[:select_imp]
			arr = []
			if !search_filial.blank? 
				sel1 = "filial_id = #{search_filial}"
				arr.push(sel1)
			end
			if !search_importance.blank? 
				sel2 = "level = #{search_importance}"
				arr.push(sel2)
			end			
			$search_req = arr.map do |field|
				query_string = "#{field}"
			end.join(' AND ')			
			@requirements = Requirement.where($search_req).paginate(page: params[:page], :per_page => 20)
	   end

  end
=end
  ########################################################################################  
	def index
		@fil_options = Filial.all #.map{|f| [ f.name, f.id ] }
		@fil = Filial.find(current_user.filial_id)
		@fil_id = @fil.id
		@levels = Requirement.select(:level).order(:level).map(&:level).uniq #.map(&:level).uniq # все существующие уровни
		if (!params[:select_filial].blank?) or (!params[:select_imp].blank?)
			$search_req = ""
			search_filial = params[:select_filial]
			search_importance = params[:select_imp]
			arr = []
			if !search_filial.blank? 
				sel1 = "filial_id = #{search_filial}"
				arr.push(sel1)
			end
			if !search_importance.blank? 
				sel2 = "level = #{search_importance}"
				arr.push(sel2)
			end					
			$search_req = arr.map do |field|
				query_string = "#{field}"
			end.join(' AND ')			
			@requirements = Requirement.where($search_req).paginate(page: params[:page], :per_page => 20)
		else
			@requirements = Requirement.paginate(page: params[:page], :per_page => 20).order(:filial_id)
		end
	end
########################################################################################
  def export_req
	if (!params[:exportreq_fil].blank?) or (!params[:exportreq_imp].blank?)
		$search_req = ""
		imp = params[:exportreq_imp]
		fil = params[:exportreq_fil]
		arr = []
		if !fil.blank? 
			sel1 = "filial_id = #{fil}"
			arr.push(sel1)
		end
		if !imp.blank? 
			sel2 = "level = #{imp}"
			arr.push(sel2)
		end					
		$search_req = arr.map do |field|
			query_string = "#{field}"
		end.join(' AND ')			
		@req = Requirement.where($search_req)
	else
		@req = Requirement.all.order( filial_id: :asc, level: :asc)
	end
begin	
	respond_to do |format|
			format.html
    	    format.csv { send_data  @req.to_csv_new(col_sep: "\t"),  :type => 'charset=iso-8859-1', filename: "Req-#{Date.today}.csv" }
	end
end	
  end
########################################################################################
  def show
  end
########################################################################################
  def new
  	
    @requirement = Requirement.new
	    @fil_options = Filial.all.map{|f| [ f.name, f.id ] }
		@fil = Filial.find(current_user.filial_id)
		@fil_id = @fil.id
  end
########################################################################################
  def edit
			
  		@fil_options = Filial.all.map{|f| [ f.name, f.id ] }
		@fil = Filial.find(current_user.filial_id)
		@fil_id = @fil.id
  end
########################################################################################
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
########################################################################################
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
########################################################################################
  def destroy
  	SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name 
    @requirement.destroy
    respond_to do |format|
      format.html { redirect_to requirements_url, notice: 'Потребность удалена.' }
      format.json { head :no_content }
    end
  end
########################################################################################
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
