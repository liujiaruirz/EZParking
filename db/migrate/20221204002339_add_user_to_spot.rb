class AddUserToSpot < ActiveRecord::Migration[5.2]
  def change
    add_column :spots, :user, :integer
  end
end
