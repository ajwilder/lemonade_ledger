module DaysHelper

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
      return '-'
    else
      return day["#{item}_end"] - day["#{item}_start"] + inventory_used(day, item)
    end
  end

end
