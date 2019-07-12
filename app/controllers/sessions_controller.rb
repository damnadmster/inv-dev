class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
	log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
#	remember user
	SpecialLog.debug "IP:" + request.remote_ip + " ; login user:" + user.name
	redirect_back_or user
    else
        flash.now[:danger] = 'неправильная пара почта/пароль' 
        SpecialLog.error "IP:" + request.remote_ip + "; ОШИБОЧНАЯ ПОПЫТКА ВХОДА user:" + params[:session][:email].downcase
        render 'new'
    end
  end

  def destroy
    SpecialLog.debug "IP:" + request.remote_ip + " ; logout user:" + current_user.name
    log_out if logged_in?
    redirect_to root_url
  end
end
