class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    #@cart_item = CartItem.find(params[:id])
  end

  def create
    @item = Item.find(params[:cart_item][:item_id])
    #if @cart_item
      #cart_item.amount = @cart_item.amount + cart_item.amount
      # @cart_item.update(amount: cart_item)
      #reediect_to
   # else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.item_id = @item.id
      @cart_item.customer_id = current_customer.id
      @cart_item.save
      redirect_to cart_items_path
   # end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
    render :index
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    @cart_items = CartItem.all
    render :index
  end
  

  private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :amount)
  end
end
