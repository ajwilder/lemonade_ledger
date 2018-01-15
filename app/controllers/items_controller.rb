class ItemsController < ApplicationController
  before_action :authenticated
  before_action :admin_authenticate

  def new
    @item = Item.new
  end

  def show
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:info] = "New item \"#{@item.name}\" Saved"
      redirect_to '/admin'
    else
      flash[:danger] = "Failed to save new item"
      render 'new'
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:info] = "#{@item.name} updated"
      redirect_to '/admin'
    else
      flash[:danger] = "Update failed"
      render 'edit'
    end
  end

  def index
    @items = Item.all
  end

  def delete
    Item.find(params[:id]).destroy
    flash[:info] = "item deleted"
    redirect_to '/admin'
  end

  private
    def item_params
      params.require(:item).permit(:price, :name, :vendor_price, :active, :cup_type, :drink_type)
    end
end
