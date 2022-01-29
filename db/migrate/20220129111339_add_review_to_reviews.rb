class AddReviewToReviews < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews, :review, :float, :null => false, :default => 0
  end
end
