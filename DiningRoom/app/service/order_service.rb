class OrderService

  def self.pick_order(user)

    order = Order.where(user_id: user.id, order_date: DateTime.now.at_beginning_of_day)

    if order.blank? && Time.now<Time.parse($pick_order_time_limit)
      order = Order.create(user_id: user.id, order_date: DateTime.now.at_beginning_of_day, status: OrderState::ORDERED)
    end
  end

end