require "application_system_test_case"

class PermissionGroupItemsTest < ApplicationSystemTestCase
  setup do
    @permission_group_item = permission_group_items(:one)
  end

  test "visiting the index" do
    visit permission_group_items_url
    assert_selector "h1", text: "Permission Group Items"
  end

  test "creating a Permission group item" do
    visit permission_group_items_url
    click_on "New Permission Group Item"

    fill_in "Permission group", with: @permission_group_item.permission_group_id
    fill_in "Permission", with: @permission_group_item.permission_id
    click_on "Create Permission group item"

    assert_text "Permission group item was successfully created"
    click_on "Back"
  end

  test "updating a Permission group item" do
    visit permission_group_items_url
    click_on "Edit", match: :first

    fill_in "Permission group", with: @permission_group_item.permission_group_id
    fill_in "Permission", with: @permission_group_item.permission_id
    click_on "Update Permission group item"

    assert_text "Permission group item was successfully updated"
    click_on "Back"
  end

  test "destroying a Permission group item" do
    visit permission_group_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Permission group item was successfully destroyed"
  end
end
