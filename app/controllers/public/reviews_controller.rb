class Public::ReviewsController < ApplicationController
  def new
    @review=Review.new
  end

  def show
  end

  def create
    @review = Review.new(review_params)
    @review.customer_id = current_customer.id
    @review.item_id = params[:item_id]
    if @review.save
      redirect_to item_path(params[:item_id])
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    # unless
    if @review.customer_id == current_customer.id
      @review.update(review_params)
      redirect_to item_path(params[:item_id])

    end
  end

  def destroy
  end

  private
  def review_params
    params.require(:review).permit(:review_body, :evaluation) # evaluationを追加
  end


end
