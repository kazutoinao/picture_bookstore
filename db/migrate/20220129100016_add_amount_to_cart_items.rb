class AddAmountToCartItems < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_items, :amount, :integer
    change_column :cart_items, :amount, :integer, :null => false
  end
end
