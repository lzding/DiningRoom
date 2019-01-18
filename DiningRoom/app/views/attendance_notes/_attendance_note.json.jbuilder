json.extract! attendance_note, :id, :user_id, :work_date, :status, :on_duty_time, :off_duty_time, :fill_clock_time, :fill_clock_type, :remark, :over_times, :created_at, :updated_at
json.url attendance_note_url(attendance_note, format: :json)
