class ChangeAttendanceNoteUserId < ActiveRecord::Migration[5.2]
  def change
    change_table :attendance_notes do |t|
      t.change :user_id, :string
    end
  end
end
