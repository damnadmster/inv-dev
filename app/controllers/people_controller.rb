class PeopleController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :new, :index, :create, :show]
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    if current_user.admin?
	@people = Person.all.order(:FIO)
    else
	fil = Filial.find(current_user.filial_id)
	@people = fil.people.paginate(page: params[:page], :per_page => 10)
    end
#    SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name
  end

  # GET /people/1
  # GET /people/1.json
  def show
    SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name   + "; View: " +  self.action_name
  end

  # GET /people/new
  def new
	@person = Person.new
	@fil_options = Filial.all.map{|f| [ f.name, f.id ] }
	@fil = Filial.find(current_user.filial_id)
    
  end

  # GET /people/1/edit
  def edit
    SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name + "; материально отв.: " + @person.FIO
    @fil_options = Filial.all.map{|f| [ f.name, f.id ] }
    @fil = Filial.find(current_user.filial_id)
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    @fil = Filial.find(current_user.filial_id)
    @fil_options = Filial.all.map{|f| [ f.name, f.id ] }
    respond_to do |format|
      if @person.save
	SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name + "; материально отв.: " + @person.FIO
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    @fil_options = Filial.all.map{|f| [ f.name, f.id ] }
    respond_to do |format|
      if @person.update(person_params)
	SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name + "; материально отв.: " + @person.FIO
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name + "; материально отв.: " + @person.FIO
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:FIO, :filial_id)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Зарегайся"
        redirect_to login_url
      end
    end

end
