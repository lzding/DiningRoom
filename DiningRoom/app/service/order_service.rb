class OrderService

  def self.pick_order(user)

    order = Order.where(user_id: user.id, order_date: Time.now.strftime("%y-%m-%d"))

    if true #order.blank?
      order = Order.create(user_id: user.id, order_date: Time.now.strftime("%y-%m-%d"), status: OrderState::ORDERED)
    end
  end

end