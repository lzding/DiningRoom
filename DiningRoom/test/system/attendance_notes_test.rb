require "application_system_test_case"

class AttendanceNotesTest < ApplicationSystemTestCase
  setup do
    @attendance_note = attendance_notes(:one)
  end

  test "visiting the index" do
    visit attendance_notes_url
    assert_selector "h1", text: "Attendance Notes"
  end

  test "creating a Attendance note" do
    visit attendance_notes_url
    click_on "New Attendance Note"

    fill_in "Fill clock time", with: @attendance_note.fill_clock_time
    fill_in "Fill clock type", with: @attendance_note.fill_clock_type
    fill_in "Off duty time", with: @attendance_note.off_duty_time
    fill_in "On duty time", with: @attendance_note.on_duty_time
    fill_in "Over times", with: @attendance_note.over_times
    fill_in "Remark", with: @attendance_note.remark
    fill_in "Status", with: @attendance_note.status
    fill_in "User", with: @attendance_note.user_id
    fill_in "Work date", with: @attendance_note.work_date
    click_on "Create Attendance note"

    assert_text "Attendance note was successfully created"
    click_on "Back"
  end

  test "updating a Attendance note" do
    visit attendance_notes_url
    click_on "Edit", match: :first

    fill_in "Fill clock time", with: @attendance_note.fill_clock_time
    fill_in "Fill clock type", with: @attendance_note.fill_clock_type
    fill_in "Off duty time", with: @attendance_note.off_duty_time
    fill_in "On duty time", with: @attendance_note.on_duty_time
    fill_in "Over times", with: @attendance_note.over_times
    fill_in "Remark", with: @attendance_note.remark
    fill_in "Status", with: @attendance_note.status
    fill_in "User", with: @attendance_note.user_id
    fill_in "Work date", with: @attendance_note.work_date
    click_on "Update Attendance note"

    assert_text "Attendance note was successfully updated"
    click_on "Back"
  end

  test "destroying a Attendance note" do
    visit attendance_notes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Attendance note was successfully destroyed"
  end
end
