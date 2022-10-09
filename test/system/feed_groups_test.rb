require "application_system_test_case"

class FeedGroupsTest < ApplicationSystemTestCase
  setup do
    @feed_group = feed_groups(:one)
  end

  test "visiting the index" do
    visit feed_groups_url
    assert_selector "h1", text: "Feed groups"
  end

  test "should create feed group" do
    visit feed_groups_url
    click_on "New feed group"

    fill_in "Name", with: @feed_group.name
    click_on "Create Feed group"

    assert_text "Feed group was successfully created"
    click_on "Back"
  end

  test "should update Feed group" do
    visit feed_group_url(@feed_group)
    click_on "Edit this feed group", match: :first

    fill_in "Name", with: @feed_group.name
    click_on "Update Feed group"

    assert_text "Feed group was successfully updated"
    click_on "Back"
  end

  test "should destroy Feed group" do
    visit feed_group_url(@feed_group)
    click_on "Destroy this feed group", match: :first

    assert_text "Feed group was successfully destroyed"
  end
end
