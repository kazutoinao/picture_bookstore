class Public::ItemsController < ApplicationController
  def index
    @items=Item.all
  end

  def show
    @item=Item.find(params[:id])
    @cart_item=CartItem.new
    @reviews=@item.reviews
  end

  def search
    @q = Item.ransack(params[:q])
    @items = @q.result
    render :index
  end

  def category_search
     @items=Item.where(category_id: params[:category_id])
     render :index
  end

end
