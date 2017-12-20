class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :description
      t.float :price
      t.string :rules
      t.string :address
      t.string :images
      t.integer :city_id
      t.integer :user_id
      t.string :latitude
      t.string :longitude

      t.timestamps null: false
    end
  end
end
