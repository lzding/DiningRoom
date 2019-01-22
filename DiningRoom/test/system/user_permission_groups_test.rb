require "application_system_test_case"

class UserPermissionGroupsTest < ApplicationSystemTestCase
  setup do
    @user_permission_group = user_permission_groups(:one)
  end

  test "visiting the index" do
    visit user_permission_groups_url
    assert_selector "h1", text: "User Permission Groups"
  end

  test "creating a User permission group" do
    visit user_permission_groups_url
    click_on "New User Permission Group"

    fill_in "Permission group", with: @user_permission_group.permission_group_id
    fill_in "User", with: @user_permission_group.user_id
    click_on "Create User permission group"

    assert_text "User permission group was successfully created"
    click_on "Back"
  end

  test "updating a User permission group" do
    visit user_permission_groups_url
    click_on "Edit", match: :first

    fill_in "Permission group", with: @user_permission_group.permission_group_id
    fill_in "User", with: @user_permission_group.user_id
    click_on "Update User permission group"

    assert_text "User permission group was successfully updated"
    click_on "Back"
  end

  test "destroying a User permission group" do
    visit user_permission_groups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User permission group was successfully destroyed"
  end
end
