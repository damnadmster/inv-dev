class LogController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :new, :index, :create, :show]
 
 def index
    SpecialLog.debug "IP:" + request.remote_ip + "; user:" + current_user.name  + "; Controller: " + self.controller_name + "; View: " +  self.action_name 
    #@files = tail
  end

private

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Зарегайся"
        redirect_to login_url
      end
    end


end
