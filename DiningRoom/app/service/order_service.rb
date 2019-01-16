class OrderService

  def self.pick_order(user)

    order = Order.where(user_id: user.id, order_date: DateTime.now.next_day.at_beginning_of_day)

    if order.blank?
      order = Order.create(user_id: user.id, order_date: DateTime.now.next_day.at_beginning_of_day, status: OrderState::ORDERED)
    end
  end

end