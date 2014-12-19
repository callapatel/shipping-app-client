class OrderForm
  attr_accessor :order

  def initialize(order, params)
    @order = order
    @order.build_credit_card(params.require(:credit_card).permit!)
    @order.update(ship_price: (params[:ship_price]))
  end

  def save
    @order.save
  end

end
