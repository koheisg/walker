class FeedGroups::Feeds::Items::WeeklyController < ApplicationController
  skip_before_action :authenticate
  before_action :set_date

  def show
    @default_feed_groups = FeedGroup.default
    @feed = Feed.find(params[:feed_id])
    @feed_group = FeedGroup.find(params[:feed_group_id])
    @feeds = @feed_group.feeds
    @items = @feed.items.includes(:item_ogp).where(created_at: (@date.weeks_ago(1))...(@date.next_day))
  end
end
