class AttendanceNote < ApplicationRecord

  include Extensions::UUID


  belongs_to :user


end
