class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_items =  @order.order_items
  end
  
  private
  params.require(:order).permit(:customer_id, :postal_code, :address, :delivery_name, :delivery_price, :payment_price, :payment_method)
end
