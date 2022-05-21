class Public::CartItemsController < ApplicationController
    def  index
        #ログインしているお客様のカートアイテム
        @cart_items=current_customer.cart_items
        #0を代入
        @total=0
        #カートアイテムログインしているお客様のカートアイテム
        @cart_items.each do |cart_item|
            @total=@total+cart_item.total_price
        end
    end

    def  update
       @cart_item=CartItem.find(params[:id])
    if @cart_item.update(amount_params)
       redirect_to cart_items_path
    else
       @cart_item=current_customer.cart_items
       render :index
    end
    end

    def  destroy
      cart_item=CartItem.find(params[:id])
      cart_item.destroy
      redirect_to cart_items_path
    end

    def  destroy_all
      @cart_items=current_customer.cart_items
      @cart_items.destroy_all
      redirect_to cart_items_path
    end

    def  create
        @cart_item=CartItem.new(cart_item_params)
        @cart_items=current_customer.cart_items.all
        @cart_items.each do |cart_item|
            if cart_item.item_id==@cart_item.item_id
               new_amount=cart_item.amount+@cart_item.amount
               cart_item.update_attribute(:amount, new_amount)
               @cart_item.delete
            end
        end
        if  @cart_item.save
            redirect_to cart_items_path
        else
            render :index
        end
    end
    private
    def cart_item_params
        params.require(:cart_item).permit(:amount, :item_id, :customer_id)
    end

    def amount_params
        params.require(:cart_item).permit(:amount)
    end
end
