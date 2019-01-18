require 'test_helper'

class AttendanceNotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attendance_note = attendance_notes(:one)
  end

  test "should get index" do
    get attendance_notes_url
    assert_response :success
  end

  test "should get new" do
    get new_attendance_note_url
    assert_response :success
  end

  test "should create attendance_note" do
    assert_difference('AttendanceNote.count') do
      post attendance_notes_url, params: { attendance_note: { fill_clock_time: @attendance_note.fill_clock_time, fill_clock_type: @attendance_note.fill_clock_type, off_duty_time: @attendance_note.off_duty_time, on_duty_time: @attendance_note.on_duty_time, over_times: @attendance_note.over_times, remark: @attendance_note.remark, status: @attendance_note.status, user_id: @attendance_note.user_id, work_date: @attendance_note.work_date } }
    end

    assert_redirected_to attendance_note_url(AttendanceNote.last)
  end

  test "should show attendance_note" do
    get attendance_note_url(@attendance_note)
    assert_response :success
  end

  test "should get edit" do
    get edit_attendance_note_url(@attendance_note)
    assert_response :success
  end

  test "should update attendance_note" do
    patch attendance_note_url(@attendance_note), params: { attendance_note: { fill_clock_time: @attendance_note.fill_clock_time, fill_clock_type: @attendance_note.fill_clock_type, off_duty_time: @attendance_note.off_duty_time, on_duty_time: @attendance_note.on_duty_time, over_times: @attendance_note.over_times, remark: @attendance_note.remark, status: @attendance_note.status, user_id: @attendance_note.user_id, work_date: @attendance_note.work_date } }
    assert_redirected_to attendance_note_url(@attendance_note)
  end

  test "should destroy attendance_note" do
    assert_difference('AttendanceNote.count', -1) do
      delete attendance_note_url(@attendance_note)
    end

    assert_redirected_to attendance_notes_url
  end
end
