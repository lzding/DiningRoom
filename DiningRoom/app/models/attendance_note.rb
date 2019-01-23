class AttendanceNote < ApplicationRecord

  include Extensions::UUID

  default_scope { order(work_date: :DESC, status: :DESC) }


  belongs_to :user

  def calc_over_times off_duty_time=Time.now

    normal_off_duty_time = Time.parse("#{self.work_date.localtime.strftime('%Y-%m-%d')} #{$normal_off_duty_time}")
    if normal_off_duty_time >= off_duty_time
      return 0.0
    else
      ((off_duty_time - normal_off_duty_time)/3600).round(1)
    end
  end


end
