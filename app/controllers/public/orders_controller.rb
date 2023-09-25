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
    @order.delivery_price = 800
    @order.payment_price = 0
    current_customer.cart_items.each do |cart_item|
    @order.payment_price = @order.payment_price + cart_item.subtotal
    end
    @order.save!
    current_customer.cart_items.each do |cart_item|
      @ordered_item = OrderItem.new
      @ordered_item.order_id =  @order.id
      @ordered_item.item_id = cart_item.item_id
      @ordered_item.amount = cart_item.amount
      @ordered_item.purchase_price = cart_item.item.price
      @ordered_item.save!
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_finish_path
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @ordered_items = @order.order_item
  end


  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :delivery_name, :delivery_price, :payment_price, :payment_method)
  end

end
