class ChangeColumnSpecialPrices < ActiveRecord::Migration
  def change
  	change_column :special_prices, :price, :float
  end
end
