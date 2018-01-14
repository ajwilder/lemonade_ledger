module DaysHelper

  def day_display(day)
     day.created_at.strftime("%m/%d").to_s + " " +  day.location
  end


end
