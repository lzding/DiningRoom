json.extract! order, :id, :user, :order_date, :status, :pick_user_id, :created_at, :updated_at
json.url order_url(order, format: :json)
