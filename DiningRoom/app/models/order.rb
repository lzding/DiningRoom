class Order < ApplicationRecord

  include Extensions::UUID

  # default_scope { where(user_id: current_user.id) }

  belongs_to :user
  # belongs_to :position_object, class_name: 'Position', foreign_key: :position




end
