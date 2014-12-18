require 'HTTParty'
class CartController < ApplicationController

  def create
    if current_order.items.create(product_id: params[:product_id])
      redirect_to cart_path

    end
  end

  def show
    if current_order.address
      @productinfo = current_order.items.product #gives all the product ID's in the line items stash
      #gives you all the product IDs
      @array = []
      @productinfo.each do |lineitem|
        @ids = lineitem[0].product_id
        @weight = Product.find(@ids).weight
        @array << @weight
      end
      @items_to_determine_packagecount = (@productinfo.count - 1)

      @address = current_order.address
      r = HTTParty.get('http://shipmypants.herokuapp.com/?',:query => {
        :country => 'US',
        :state => current_order.address.state.upcase,
        :city => current_order.address.city,
        :zip => current_order.address.postal_code,
        :weight => @array.sum.to_i
        }
      )
      r.parsed_response
      raise
    end

  end
end
