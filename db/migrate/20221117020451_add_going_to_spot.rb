class AddGoingToSpot < ActiveRecord::Migration[5.2]
  def change
    add_column :spots, :going, :integer
  end
end
