class AddPointsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :points, :integer, :default => 5
  end
end
