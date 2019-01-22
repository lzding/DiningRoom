#############################菜单管理##################################

unless Permission.find_by_name("view_attendance_note")
  Permission.create(name: "view_attendance_note", description: "查看考勤菜单")
end

###########################权限管理################################

unless Permission.find_by_name("manage_permission")
  Permission.create(name: "manage_permission", description: "权限管理中心")
end

############################操作权限#########################

unless Permission.find_by_name("operate_basic_info_create")
  Permission.create(name: "operate_basic_info_create", description: "基础信息新建权限")
end

unless Permission.find_by_name("operate_basic_info_edit")
  Permission.create(name: "operate_basic_info_edit", description: "基础信息编辑权限")
end

unless Permission.find_by_name("operate_basic_info_delete")
  Permission.create(name: "operate_basic_info_delete", description: "基础信息删除权限")
end



