class DaysController < ApplicationController
  before_action :authenticated
  before_action :admin_authenticate, only: [:summary, :edit, :update]
  skip_before_action :verify_authenticity_token, only: [:checklist, :am_checklist, :close_day, :final_restock, :close]


  def new
  end

  def checklist
    @location = params[:location]
    if @location == "Market Street" || @location == "Night Market"
      market_day = Day.find_by(location: "Market Street")
      night_day = Day.find_by(location: "Night Market")
      if night_day
        if market_day.created_at > night_day.created_at
          @previous_day = market_day
        else
          @previous_day = night_day
        end
      else
        @previous_day = market_day
      end
    else
      @previous_day = Day.find_by(location: @location)
    end
    @day = Day.new
    @employees = Admin.first.employees
    @locations = Admin.first.locations
    Time.zone = "America/New_York"
    @date = Time.new.in_time_zone.strftime("%m/%d/%y")
    render 'new'
  end


  def am_checklist
    @admin = Admin.first
    @farmers_list = @admin.farmers_am
    @city_list = @admin.city_am
  end

  def index
    @open_days = Day.where(closed: false)
    @closed_days = Day.where(closed: true)
  end

  def show
    @day = Day.find(params[:id])
    if @day.closed?
      flash[:danger] = "Day has been closed.  Only Summary available"
      redirect_to summary_day_path(@day) and return
    end
    @sales = @day.sales
  end

  def create
    @day = Day.new(new_day_params)
    if params[:employees]
      params[:employees].each do |employee|
        @day.employees << employee
      end
    end
    if Day.find_by(location: params[:day][:location], date: params[:day][:date])
      flash[:danger] = "There is already a ledger open at this location today"
      redirect_to root_url and return
    end
    if @day.save
      if !current_day.nil?
        cookies.delete(:day)
      end
      cookies.signed[:day] = { value:
        @day.id, expires: 16.hours.from_now }
      AdminMailer.new_day(@day).deliver_now
      days = Day.where('created_at < ?', 10.day.ago)
      days.each do |d|
        d.destroy
      end
      redirect_to @day
    else
      @employees = Admin.first.employees
      @locations = Admin.first.locations
      render 'new'
    end
  end

  def edit
    @day = Day.find(params[:id])

  end

  def update
    @day = Day.find(params[:id])
    if @day.update_attributes(update_day_params)
      flash[:info] = 'Ledger updated by admin'
      redirect_to '/admin'
    else
      flash[:danger] = 'Update failed'
      redirect_to '/admin'
    end
  end

  def summary
    @day = Day.find(params[:id])
    if @day.sales.length == 0
      flash[:danger] = "no sales to summarize yet"
      redirect_to @day
    end
    @sales = @day.sales.order(:created_at)

    @item_sales = {}
    @day.sales.each do |sale|
      items = sale.items
      items.each do |item|
        if @item_sales.key?(item)
          @item_sales[item] += 1
        else
          @item_sales[item] = 1
        end
      end
    end
  end

  def emergency_restock_page
    @day = Day.find(params[:id])
  end

  def emergency_restock
    @day = Day.find(params[:id])
    @admin = Admin.first
    if @day.update_attributes(emergency_restock_params)
      flash[:info] = "Inventory updated"
      @admin.update_attributes(
        small_invent: @admin.small_invent - params[:day][:small_emergency_restock].to_i,
        large_invent: @admin.large_invent - params[:day][:large_emergency_restock].to_i,
        hot_small_invent: @admin.hot_small_invent - params[:day][:hot_small_emergency_restock].to_i,
        hot_medium_invent: @admin.hot_medium_invent - params[:day][:hot_medium_emergency_restock].to_i,
        bottles_invent: @admin.bottles_invent - params[:day][:bottle_emergency_restock].to_i
      )
      redirect_to @day
    else
      flash[:danger] = "Inventory Updated failed"
      redirect_to @day
    end
  end

  def close_page
    @day = Day.find(params[:id])
    @admin = Admin.first
    if @day.location == "Market Street"
      @list = @admin.city_pm
    else
      @list = @admin.farmers_pm
    end
  end

  def close
    @day = Day.find(params[:id])
    if @day.sales.length == 0
      @day.destroy
      cookies.delete(:day)
      flash[:danger] = 'Ledger closed with no sales.  Record Deleted'
      redirect_to root_path and return
    elsif (params[:day][:small_end] == '' || params[:day][:large_end] == '' || params[:day][:cash_end] == '' || params[:day][:bottle_end] == '' || params[:day][:hot_small_end] == '' || params[:day][:hot_medium_end] == '')
      flash[:danger] = "Fill in all fields to close the day"
      redirect_to close_page_day_path(@day) and return
    else
      @day.update_attributes(close_day_params)
      redirect_to final_restock_page_day_path(@day)
    end
  end

  def final_restock_page
    @day = Day.find(params[:id])
  end

  def final_restock
    @day = Day.find(params[:id])
    @admin = Admin.first
    if @day.update_attributes(final_restock_params)
      @admin.update_attributes(
        small_invent: @admin.small_invent - params[:day][:small_restock].to_i,
        large_invent: @admin.large_invent - params[:day][:large_restock].to_i,
        hot_small_invent: @admin.hot_small_invent - params[:day][:hot_small_restock].to_i,
        hot_medium_invent: @admin.hot_medium_invent - params[:day][:hot_medium_restock].to_i,
        bottles_invent: @admin.bottles_invent - params[:day][:bottle_restock].to_i
      )
      cookies.delete(:day)
      AdminMailer.close_day(@day).deliver_now
      flash[:info] = 'ledger has been closed'
      redirect_to root_url
    else
      flash[:danger] = "Final inventory update failed.  Try again."
      redirect_to final_restock_page_day_path(@day)
    end

  end

  def pm_checklist
    @day = Day.find(params[:id])
    @admin = Admin.first
    if @day.location == "Market Street"
      @list = @admin.city_pm
    else
      @list = @admin.farmers_pm
    end
  end

  def leave_note
    @day = Day.find(params[:id])
  end

  def note
    @day = Day.find(params[:id])
    @day.notes << params[:note]
    if @day.save
      flash[:info] = 'Note saved'
      redirect_to @day
    else
      flash[:danger] = 'note not saved'
      redirect_to @day
    end
  end

  private

    def new_day_params
      params.require(:day).permit(:cash_start, :location, :large_start, :small_start, :bottle_start, :hot_medium_start, :hot_small_start, :date)
    end

    def update_day_params
      params.require(:day).permit(:cash_start, :large_start, :small_start, :bottle_start, :hot_medium_start, :hot_small_start)
    end

    def final_restock_params
      params.require(:day).permit(:large_restock, :closed, :small_restock, :bottle_restock, :hot_medium_restock, :hot_small_restock)
    end

    def emergency_restock_params
      params.require(:day).permit(:large_emergency_restock, :small_emergency_restock, :bottle_emergency_restock, :hot_medium_emergency_restock, :hot_small_emergency_restock)
    end

    def close_day_params
      params.require(:day).permit(:cash_end, :large_end, :small_end, :bottle_end, :hot_medium_end, :hot_small_end)
    end

end
