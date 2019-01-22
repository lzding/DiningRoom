class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:authentication_keys => [:nr]

  include Extensions::UUID

  default_scope { order(nr: :ASC) }

  has_many :user_permission_groups, dependent: :destroy
  has_many :permission_groups, through: :user_permission_groups
  has_many :permissions, through: :permission_groups

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
        if self.permissions.where(name: args[0].to_s).blank?
          false
        else
          true
        end
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

  def manage_permission_groups ids
    deletes=self.user_permission_groups.pluck(:permission_group_id) - ids
    deletes.each do |d|
      UserPermissionGroup.where(permission_group_id: d, user_id: self.id).first.destroy
    end

    creates=ids - self.user_permission_groups.pluck(:permission_group_id)
    creates.each do |c|
      up=UserPermissionGroup.new({permission_group_id: c, user_id: self.id})
      if up.save
        self.user_permission_groups<<up
      end
    end
  end

  def permission_group_details
    data=[]

    permission_groups=self.permission_groups
    PermissionGroup.all.each do |p|
      data<<{
          id: p.id,
          name: p.name,
          desc: p.description,
          status: permission_groups.include?(p)
      }
    end
    data
  end

end
