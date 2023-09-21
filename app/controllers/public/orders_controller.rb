class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def chech
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.delivery_name = current_customer.first_name + current_customer.last_name
  end

  def finish

  end

  def create
    @order = Order.new(order_params)

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
