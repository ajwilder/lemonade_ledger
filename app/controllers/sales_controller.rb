class SalesController < ApplicationController
  def new
    @day = current_day
    @sale = @day.sales.build
    @items = Item.where(active: true).order(:drink_type)
  end

  def create
    @day = current_day
    @sale = @day.sales.build(sale_params)
    items = params[:items].split(',')
    items.each do |item|
      @sale.items << item
    end
    if @sale.save
      @day.update_attributes(
        large_end: @day.large_end - @sale.large,
        small_end: @day.small_end - @sale.small,
        bottle_end: @day.bottle_end - @sale.bottle,
        hot_small_end: @day.hot_small_end - @sale.hot_small,
        hot_medium_end: @day.hot_medium_end - @sale.hot_medium,
        cash_end: @day.cash_end + @sale.price
      )
      redirect_to new_sale_path
    else
      flash[:danger] = "Error: sale not saved"
      redirect_to new_sale_path
    end
  end

  private

    def sale_params
      params.require(:sale).permit(:hot_small, :hot_medium, :bottle, :large, :price, :small)
    end
end
