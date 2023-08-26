class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
       redirect_to public_customer_path(@customer.id)
    else
       render :edit
    end
  end
  
  def out
    @customer = current_customer
    @customer.update(is_deleted: true)
    sign_out @customer
    redirect_to root_path
  end


  private

  def customer_params
    params.require(:customers).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, :is_deleted, :email)
  end

end
