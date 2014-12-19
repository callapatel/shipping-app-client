class OrdersController < ApplicationController

  def show
    @order = Order.find_by(number: params[:number])
    @callaswonkywayforcurrentorders = (current_order.id).to_i - 1
    @productinfo = Order.find(@callaswonkywayforcurrentorders).items.product #gives all the product ID's in the line items stash
    #gives you all the product IDs
    array = []
    @productinfo.each do |lineitem|
      @ids = lineitem[0].product_id
      @weight = Product.find(@ids).weight
      array << @weight
    end
    array.sum
    @items_to_determine_packagecount = (@productinfo.count - 1)

    @address = current_order.address

  end

  def update
    order_form = OrderForm.new(current_order, params[:order])
    if order_form.save
      session[:order_number] = nil
      redirect_to order_path(order_form.order.number)
    end
  end
end
