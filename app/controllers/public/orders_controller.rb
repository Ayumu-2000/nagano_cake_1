class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def check
    @cart_items = current_customer.cart_items.all
    @total = 0
    @order = Order.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.delivery_name = current_customer.first_name + current_customer.last_name
  end

  def finish

  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @total = 0
    current_customer.cart_items.each do |cart_item|
　　  @ordered_item = OrderItem.new
　　  @ordered_item.order_id =  @order.id
      @ordered_item.item_id = cart_item.item_id
      @ordered_item.amount = cart_item.amount
      @total = @total + cart_item.subtotal
      @ordered_item.save
    end #ループ終わり
    @ordered_item.purchase_price = @total
    current_member.cart_items.destroy_all
    @ordered_item.save
    render :finish
  end

  def index

  end

  def show

  end


  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :delivery_name, :delivery_price, :payment_price, :payment_method)
  end

end
