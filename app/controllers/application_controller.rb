class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception # https://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection/ClassMethods.html
  #skip_before_action :verify_authenticity_token #You can disable forgery protection on controller by skipping the verification before_action:
			    # :null_session - Provides an empty session during request but doesn't reset it completely. Used as default if :with option is not specified.
#  before_action :set_history
  include SessionsHelper

# переопределение 404 страницы
  def route_not_found
    render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
  end

  private
#  def set_history
#	@dev_history = "" #Теперь, во всех экшенах будет доступна переменная
#  end
end
