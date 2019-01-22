class AttendanceNote < ApplicationRecord

  include Extensions::UUID

  default_scope { order(work_date: :DESC, status: :DESC) }


  belongs_to :user


end
