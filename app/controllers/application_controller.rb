class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_day
    if (day_id = cookies.signed[:day])
      Day.find_by_id(day_id)
    end
  end


  private

    def authenticated
      unless cookies.signed[:authentic] == Admin.first.password_digest
        flash[:danger] = "Password required to authenticate this device"
        redirect_to '/login'
      end
    end

    def admin_authenticate
      unless session[:admin] == Admin.first.password_digest
        flash[:danger] = 'Log in as admin'
        redirect_to admin_login_url
      end
    end

end
