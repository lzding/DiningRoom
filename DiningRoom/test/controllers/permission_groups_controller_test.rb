require 'test_helper'

class PermissionGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @permission_group = permission_groups(:one)
  end

  test "should get index" do
    get permission_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_permission_group_url
    assert_response :success
  end

  test "should create permission_group" do
    assert_difference('PermissionGroup.count') do
      post permission_groups_url, params: { permission_group: { description: @permission_group.description, name: @permission_group.name } }
    end

    assert_redirected_to permission_group_url(PermissionGroup.last)
  end

  test "should show permission_group" do
    get permission_group_url(@permission_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_permission_group_url(@permission_group)
    assert_response :success
  end

  test "should update permission_group" do
    patch permission_group_url(@permission_group), params: { permission_group: { description: @permission_group.description, name: @permission_group.name } }
    assert_redirected_to permission_group_url(@permission_group)
  end

  test "should destroy permission_group" do
    assert_difference('PermissionGroup.count', -1) do
      delete permission_group_url(@permission_group)
    end

    assert_redirected_to permission_groups_url
  end
end
