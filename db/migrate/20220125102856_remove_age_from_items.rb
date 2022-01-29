class RemoveAgeFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :age, :string
  end
end
