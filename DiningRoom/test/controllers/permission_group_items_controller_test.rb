require 'test_helper'

class PermissionGroupItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @permission_group_item = permission_group_items(:one)
  end

  test "should get index" do
    get permission_group_items_url
    assert_response :success
  end

  test "should get new" do
    get new_permission_group_item_url
    assert_response :success
  end

  test "should create permission_group_item" do
    assert_difference('PermissionGroupItem.count') do
      post permission_group_items_url, params: { permission_group_item: { permission_group_id: @permission_group_item.permission_group_id, permission_id: @permission_group_item.permission_id } }
    end

    assert_redirected_to permission_group_item_url(PermissionGroupItem.last)
  end

  test "should show permission_group_item" do
    get permission_group_item_url(@permission_group_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_permission_group_item_url(@permission_group_item)
    assert_response :success
  end

  test "should update permission_group_item" do
    patch permission_group_item_url(@permission_group_item), params: { permission_group_item: { permission_group_id: @permission_group_item.permission_group_id, permission_id: @permission_group_item.permission_id } }
    assert_redirected_to permission_group_item_url(@permission_group_item)
  end

  test "should destroy permission_group_item" do
    assert_difference('PermissionGroupItem.count', -1) do
      delete permission_group_item_url(@permission_group_item)
    end

    assert_redirected_to permission_group_items_url
  end
end
