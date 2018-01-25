class DaysController < ApplicationController
  before_action :authenticated
  before_action :admin_authenticate, only: [:summary]

  def new
    @day = Day.new
    @employees = Admin.first.employees
    @locations = Admin.first.locations
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
    if @day.save
      cookies.signed[:day] = { value:
        @day.id, expires: 30.hours.from_now }
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
    @day.update_attributes()
  end

  def summary

    @day = Day.find(params[:id])
    if @day.sales.length == 0
      flash[:danger] = "no sales to summarize yet"
      redirect_to @day
    end

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

  def restock_page
    @day = Day.find(params[:id])
  end

  def restock
    @day = Day.find(params[:day][:id])
    @day.update_attributes(restock_params)
    redirect_to @day
  end

  def close_page
    @day = Day.find(params[:id])
  end

  def close
    @day = Day.find(params[:day][:id])
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
      flash[:info] = "Day is closed"
      cookies.delete(:day)
      redirect_to root_url
    end
  end

  private

    def new_day_params
      params.require(:day).permit(:cash_start, :location, :large_start, :small_start, :bottle_start, :hot_medium_start, :hot_small_start)
    end

    def restock_params
      params.require(:day).permit(:cash_restock, :large_restock, :small_restock, :bottle_restock, :hot_medium_restock, :hot_small_restock)
    end

    def close_day_params
      params.require(:day).permit(:cash_end, :closed, :large_end, :small_end, :bottle_end, :hot_medium_end, :hot_small_end)
    end

end
