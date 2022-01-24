class Public::OrdersController < ApplicationController
 def  new
    @customer=current_customer
    @order=Order.new
    @address=Address.all
  end

  def  confirm
    @total_price=0
    @cart_items=current_customer.cart_items
    @order=Order.new(order_params)
    if  params[:order][:address_select] == "0"
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name + current_customer.first_name
      @order.address = current_customer.address

    elsif  params[:order][:address_select] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

    elsif  params[:order][:address_select] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
    if params[:order][:payment_method] =="credit_card"
      @order.payment_method="credit_card"
    elsif  params[:order][:payment_method] =="transfer"
      @order.payment_method="transfer"
    end
  end

  def  complete
  end

  def  create
    @total_price=0
    @order=Order.new(order_params)
    @cart_items=current_customer.cart_items
    @order.customer_id=current_customer.id
    if  @order.save
        @cart_items.each do |cart_item|
          @order_detail=OrderDetail.new
          @order_detail.order_id=@order.id
          @order_detail.item_id=cart_item.item_id
          @order_detail.price=cart_item.item.price
          @order_detail.amount=cart_item.amount
          @order_detail.making_status=0
          @order_detail.save
        end
        @cart_items.destroy_all
        redirect_to complete_orders_path
    else
        render :confirm
    end
  end
  def index
    @orders=Order.all
    @order_details=OrderDetail.all
  end
  def show
    @order=Order.find(params[:id])
    @order_details=@order.order_details
  end
  private
  def order_params
      params.require(:order).permit(:payment_method, :address, :name, :postal_code, :total_payment, :shipping_cost, :status)
  end
  def order_details_params
      params.require(:order_details).permit(:order_id, :item_id, :price, :amount, :making_status)
  end
end
