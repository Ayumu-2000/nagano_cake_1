class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
  end
  
  def create
    @cart_item = Item.find_by(name: params[:item][:name])
    return if !@item
    if @item.valid_name?(params[:item][:name]) && (@item.name == true)
      @cart_item.amount = @cart_item.amount + cart_item.amount
    else
      @cart_item.save
      redirect_to cart_items_path
    end 
  end
  
  def update
    
  end
  
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end
  
  def destroy_all
    @cart_items = CartItem.destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
