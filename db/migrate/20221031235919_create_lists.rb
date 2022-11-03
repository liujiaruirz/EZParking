class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.text :name
      t.text :idcard
      t.text :phone

      t.timestamps
    end
  end
end
