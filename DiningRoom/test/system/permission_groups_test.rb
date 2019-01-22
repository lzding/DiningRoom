require "application_system_test_case"

class PermissionGroupsTest < ApplicationSystemTestCase
  setup do
    @permission_group = permission_groups(:one)
  end

  test "visiting the index" do
    visit permission_groups_url
    assert_selector "h1", text: "Permission Groups"
  end

  test "creating a Permission group" do
    visit permission_groups_url
    click_on "New Permission Group"

    fill_in "Description", with: @permission_group.description
    fill_in "Name", with: @permission_group.name
    click_on "Create Permission group"

    assert_text "Permission group was successfully created"
    click_on "Back"
  end

  test "updating a Permission group" do
    visit permission_groups_url
    click_on "Edit", match: :first

    fill_in "Description", with: @permission_group.description
    fill_in "Name", with: @permission_group.name
    click_on "Update Permission group"

    assert_text "Permission group was successfully updated"
    click_on "Back"
  end

  test "destroying a Permission group" do
    visit permission_groups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Permission group was successfully destroyed"
  end
end
