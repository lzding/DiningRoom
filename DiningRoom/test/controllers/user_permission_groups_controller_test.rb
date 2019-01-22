require 'test_helper'

class UserPermissionGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_permission_group = user_permission_groups(:one)
  end

  test "should get index" do
    get user_permission_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_user_permission_group_url
    assert_response :success
  end

  test "should create user_permission_group" do
    assert_difference('UserPermissionGroup.count') do
      post user_permission_groups_url, params: { user_permission_group: { permission_group_id: @user_permission_group.permission_group_id, user_id: @user_permission_group.user_id } }
    end

    assert_redirected_to user_permission_group_url(UserPermissionGroup.last)
  end

  test "should show user_permission_group" do
    get user_permission_group_url(@user_permission_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_permission_group_url(@user_permission_group)
    assert_response :success
  end

  test "should update user_permission_group" do
    patch user_permission_group_url(@user_permission_group), params: { user_permission_group: { permission_group_id: @user_permission_group.permission_group_id, user_id: @user_permission_group.user_id } }
    assert_redirected_to user_permission_group_url(@user_permission_group)
  end

  test "should destroy user_permission_group" do
    assert_difference('UserPermissionGroup.count', -1) do
      delete user_permission_group_url(@user_permission_group)
    end

    assert_redirected_to user_permission_groups_url
  end
end
