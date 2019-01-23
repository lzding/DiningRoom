class ChangeAttendanceNoteOverTimes < ActiveRecord::Migration[5.2]
  def change
    change_column :attendance_notes, :over_times, :decimal, precision: 20, scale: 4
  end
end
