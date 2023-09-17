class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
  end

  def create
    @cart_item = Item.find_by(params[:cart_item][:item_id])
    #if @cart_item
      #cart_item.amount = @cart_item.amount + cart_item.amount
      # @cart_item.update(amount: cart_item)
      #reediect_to 
   # else
      @cart = CartItem.new(ストロングパラメータ)
      @cart.item_id = アイテムの情報.id
      @cart.customer_id = current_customer.id
      @cart_item.save
      redirect_to cart_items_path
   # end
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
