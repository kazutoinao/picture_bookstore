class AddauthorToitems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :author, :string
  end
end
