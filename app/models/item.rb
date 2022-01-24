class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :reviews, dependent: :destroy
  attachment :image
  def with_tax_price
    (price * 1.1).floor
  end
end
