class AddShippingPriceToCreditCard < ActiveRecord::Migration
  def change
    add_column :credit_cards, :ship_price, :string
  end
end
