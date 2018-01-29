module DaysHelper

  def current_day
    if (day_id = cookies.signed[:day])
      Day.find_by_id(day_id)
    end
  end

  def day_display(day)
     day.created_at.strftime("%m/%d").to_s + " " +  day.location
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
      return day["#{item}_end"] + day["#{item}_restock"]
    end
  end

end
