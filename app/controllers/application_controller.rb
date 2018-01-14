class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_day
    if (day_id = cookies.signed[:day])
      @day = Day.find(day_id)
    end
  end
end
