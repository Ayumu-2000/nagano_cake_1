class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def subtotal
    purchase_price * amount
  end
end
