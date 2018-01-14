class DaysController < ApplicationController

  def new
    @day = Day.new
    @employees = Admin.first.employees
    @locations = Admin.first.locations
  end

  def index
    @days = Day.all
  end

  def show
    @day = Day.find(params[:id])
    redirect_to summary_day_path(@day) if @day.closed?
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
        @day.id, expires: 12.hours.from_now }
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

  def restock
    @day = Day.find(params[:id])
  end

  def close_page
    @day = Day.find(params[:id])
  end

  def close
    @day = Day.find(params[:day][:id])
    @day.update_attributes(close_day_params)
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
    redirect_to '/'
  end

  private

    def new_day_params
      params.require(:day).permit(:cash_start, :location, :large_start, :small_start, :bottles_start, :hot_medium_start, :hot_small_start)
    end

    def close_day_params
      params.require(:day).permit(:cash_end, :closed, :large_end, :small_end, :bottles_end, :hot_medium_end, :hot_small_end)
    end

end
