class SalesController < ApplicationController
  before_action :authenticated
  skip_before_action :verify_authenticity_token, only: [:create]

  def new
    @day = current_day
    @last_sales = @day.sales.order('created_at desc').take(3)
    @sale = @day.sales.build

    @items = Item.where(active: true).order(:drink_type).order(:name)
  end

  def create
    @day = current_day
    @sale = @day.sales.build(sale_params)
    items = params[:items].split(',')
    items.each do |item|
      @sale.items << item
    end
    if @sale.save
      redirect_to new_sale_path
    else
      flash[:danger] = "Error: sale not saved"
      redirect_to new_sale_path
    end
  end

  private

    def sale_params
      params.require(:sale).permit(:hot_small, :hot_medium, :bottle, :large, :price, :small, :reusable_straw, :reusable_straw_bag, :donut)
    end
end
