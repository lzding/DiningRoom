class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:authentication_keys => [:nr]

  include Extensions::UUID

  validates_presence_of :nr, :message => "nr不能为空!"
  validates_uniqueness_of :nr, :message => "nr不能重复!"


  def method_missing(method_name, *args, &block)
    if Role::RoleMethods.include?(method_name)
      Role.send(method_name, self.role_id)
    elsif method_name.match(/permission?/)
      if self.admin?
        true
      else
        false
        # if self.permissions.where(name: args[0].to_s).blank?
        #   false
        # else
        #   true
        # end
      end
    else
      super
    end
  end

  def role
    Role.display(self.role_id)
  end

  def email_required?
    false
  end



  def employee?
    if self.admin? || self.manager?
      false
    else
      true
    end
  end

  def self.role_user role_id
    User.where(role_id: role_id).all
  end



end
