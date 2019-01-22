ActiveRecord::Base.transaction do
  Order.all.each do |order|
    order.update({user_nr: order.user.nr})
  end

end