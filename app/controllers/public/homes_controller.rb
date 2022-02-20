class Public::HomesController < ApplicationController
    def about
    end

    def top
      @items = Item.all
      @q = Item.ransack(params[:q])
    end

end
