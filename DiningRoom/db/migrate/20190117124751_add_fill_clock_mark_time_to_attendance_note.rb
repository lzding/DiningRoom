class AddFillClockMarkTimeToAttendanceNote < ActiveRecord::Migration[5.2]
  def up
    change_table :attendance_notes do |t|
      t.datetime :fill_clock_mark_time
    end
  end

  def down
    change_table :attendance_notes do |t|
      t.remove :fill_clock_mark_time
    end
  end
end
