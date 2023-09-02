class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end

  def show
    @ietm = Item.find(params[:id])
  end

  def index
    @items = Item.all
  end

  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end
  
  
  private 
  
  def item_params
    params.require(:item).permit(:name, :introduction, :price)
  end
end
