class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total = 0
    #@cart_item = CartItem.find(params[:id])
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @item = Item.find(params[:cart_item][:item_id])
    @cart_item.item_id = @item.id
    @cart_item.customer_id = current_customer.id
    @total = 0
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      @cart_item_ex = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      new_amount = @cart_item.amount + @cart_item_ex.amount
      @cart_item_ex.update_attribute(:amount, new_amount)
      @cart_item.destroy
      redirect_to cart_items_path
    elsif @cart_item.save
      redirect_to cart_items_path
    else
      @cart_items = CartItem.all
      render 'index'
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    @cart_items = CartItem.all
    redirect_to cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :amount)
  end
end
