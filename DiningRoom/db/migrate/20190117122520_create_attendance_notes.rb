class CreateAttendanceNotes < ActiveRecord::Migration[5.2]
  def up
    create_table( :attendance_notes, :id => false) do |t|
      t.string :id, :limit => 36, :primary => true, :null => false

      t.references :user, index: true
      t.datetime :work_date
      t.integer :status
      t.datetime :on_duty_time
      t.datetime :off_duty_time
      t.datetime :fill_clock_time
      t.integer :fill_clock_type
      t.string :remark
      t.integer :over_times

      t.timestamps
    end

    add_index :attendance_notes, :status
    add_index :attendance_notes, :fill_clock_type
    add_index :attendance_notes, :work_date
    execute 'ALTER TABLE attendance_notes ADD PRIMARY KEY(id)'
  end

  def down
    drop_table :attendance_notes
  end
end
