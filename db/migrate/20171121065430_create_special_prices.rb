class CreateSpecialPrices < ActiveRecord::Migration
  def change
    create_table :special_prices do |t|
      t.date :start_date
      t.date :end_date
      t.integer :price
      t.integer :room_id

      t.timestamps null: false
    end
  end
end
