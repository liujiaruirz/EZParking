class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.datetime :time2leave
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
