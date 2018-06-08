module DaysHelper

  def current_day
    if (day_id = cookies.signed[:day])
      Day.find_by_id(day_id)
    end
  end

  def day_display(day)
    if day.date
      day.date + " " +  day.location
    else
      day.created_at.strftime("%m/%d").to_s + " " +  day.location
    end
  end

  def total_sales(day)
    '%.2f' % (day.sales.collect {|sale| sale.price }.reduce(:+)).round(2)
  end

  def cash_received(day)
    '%.2f' % (day.cash_end - day.cash_start).round(2)
  end

  def cash_discrepancy(day)
    '%.2f' % (day.cash_end - day.cash_start - (day.sales.collect {|sale| sale.price }.reduce(:+))).round(2)
  end

  def inventory_used(day, item)
    day.sales.collect {|sale| sale[item]}.reduce(:+)
  end

  def inventory_discrepancy(day, item)
    if !day.closed?
      return 'n/a'
    else
      return day["#{item}_end"] - (day["#{item}_start"] + day["#{item}_emergency_restock"]  - inventory_used(day, item))
    end
  end

  def tommorrow_count(day, item)
    if !day.closed?
      return 'n/a'
    else
      if day["#{item}_end"]
        item_end = day["#{item}_end"]
      else
        item_end = 0
      end
      if day["#{item}_restock"]
        item_restock = day["#{item}_restock"]
      else
        item_restock = 0
      end
      return item_end + item_restock
    end
  end

  def sale_time(time)
    Time.zone = "America/New_York"
    t = time.in_time_zone
    t.strftime("%I:%M%p")
  end

end
