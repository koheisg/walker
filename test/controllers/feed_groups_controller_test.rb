require "test_helper"

class FeedGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @feed_group = feed_groups(:one)
  end

  test "should get index" do
    get feed_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_feed_group_url
    assert_response :success
  end

  test "should create feed_group" do
    assert_difference("FeedGroup.count") do
      post feed_groups_url, params: { feed_group: { name: @feed_group.name } }
    end

    assert_redirected_to feed_group_url(FeedGroup.last)
  end

  test "should show feed_group" do
    get feed_group_url(@feed_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_feed_group_url(@feed_group)
    assert_response :success
  end

  test "should update feed_group" do
    patch feed_group_url(@feed_group), params: { feed_group: { name: @feed_group.name } }
    assert_redirected_to feed_group_url(@feed_group)
  end

  test "should destroy feed_group" do
    assert_difference("FeedGroup.count", -1) do
      delete feed_group_url(@feed_group)
    end

    assert_redirected_to feed_groups_url
  end
end
