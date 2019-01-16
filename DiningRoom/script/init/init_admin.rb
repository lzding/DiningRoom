ActiveRecord::Base.transaction do
  unless user=User.find_by_nr('admin')
    user = User.create({name: 'Admin', role_id: 100, nr: 'admin', password: '123456@', password_confirmation: '123456@'})
  end
end
