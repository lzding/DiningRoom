class Role
  RoleMethods=[:admin?, :manager?, :worker?]

  @@roles={
      :'100' => {:name => 'admin', :display => '系统管理员'},
      :'200' => {:name => 'manager', :display => '管理员'},
      :'300' => {:name => 'worker', :display => '员工'},
  }

  class<<self
    RoleMethods.each do |m|
      define_method(m) { |id|
        @@roles[id_sym(id)][:name]==m.to_s.sub(/\?/, '')
      }
    end
    @@roles.each do |key, value|
      define_method(value[:name]) {
        key.to_s.to_i
      }
    end
  end

  def self.display id
    if @@roles[id_sym(id)]
      @@roles[id_sym(id)][:display]
    else
      'No Role'
    end
  end

  def self.id_sym id
    id.to_s.to_sym
  end

  def self.menu with_no_admin=true
    roles = []
    @@roles.each { |key, value|
      if with_no_admin
        roles <<[value[:display], key.to_s] unless key.to_s==self.admin.to_s
      else
        roles <<[value[:display], key.to_s]
      end
    }
    roles
  end

  def self.find_role_num str
    case str
      when '系统管理员'
        self.admin
      when '管理员'
        self.manager
      when '员工'
        self.worker
    end
  end


end
