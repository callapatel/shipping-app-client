class AddShippingOptionToCreditCard < ActiveRecord::Migration
  def change
    add_column :credit_cards, :ship_option, :string
  end
end
