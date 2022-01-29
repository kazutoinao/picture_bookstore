class AddillustratorToitems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :illustrator, :string
  end
end
