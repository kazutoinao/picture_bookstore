class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :customer_id, null:false
      t.integer :item_id, null:false
      t.float :review, null:false
      t.text :review_body, null:false
      t.timestamps
    end
  end
end
