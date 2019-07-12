class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :new, :index, :create, :show]
#  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  def show
        @user = User.find(params[:id])
	# debugger
  end
  def new
    if current_user.admin?
	SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name 
	@user = User.new
	@fil_options = Filial.all.map{|f| [ f.name, f.id ] }
    else
	flash[:danger] = "Будь админом!"
	redirect_to users_url
    end
  end

  def edit
    if current_user.admin?
		SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name 
		@user = User.find(params[:id])
		@fil_options = Filial.all.map{|f| [ f.name, f.id ] }
    else
		flash[:danger] = "Будь админом!"
		redirect_to users_url
    end
  end

  def edit_right
    if current_user.admin?
		SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name 
		@user = User.find(params[:userid])
		@fil_options = Filial.all.map{|f| [ f.name, f.id ] }
    else
		flash[:danger] = "Будь админом!"
		redirect_to users_url
    end
  end


    
  def index
    @users = User.paginate(page: params[:page],:per_page => 10).order(:name)
#    SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name
  end


  def create
    if current_user.admin?
	@fil_options = Filial.all.map{|f| [ f.name, f.id ] }
	@user = User.new(user_params)    # Not the final implementation!
	if @user.save
    	    SpecialLog.warn "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name + "; user: " + @user.name
    	    # log_in @user
    	    #flash[:success] = "вход выполнен"
    	    redirect_to @user
	else
    	    render 'new'
	end
    else
	flash[:danger] = "Будь админом!"
	redirect_to users_url
    end
 end

  def update
    if current_user.admin?
	@fil_options = Filial.all.map{|f| [ f.name, f.id ] }
	@user = User.find(params[:id])
	if @user.update_attributes(user_params)
    	    # Handle a successful update.
    	    SpecialLog.warn "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name + "; user: " + @user.name
    	    flash[:success] = "профиль обновлен"
    	    redirect_to @user
	else
    	    render 'edit'
	end
    else
	flash[:danger] = "Будь админом!"
	redirect_to users_url
    end
  end

  def destroy
    @user = User.find(params[:id])
    SpecialLog.warn "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name + "; user: " + @user.name
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'пользователь успешно удален.' }
      format.json { head :no_content }
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :filial_id, :admin, :right, :password,
                                   :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
	store_location
        flash[:danger] = "Зарегайся"
        redirect_to login_url
      end
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless  current_user?(@user)
    end
end
