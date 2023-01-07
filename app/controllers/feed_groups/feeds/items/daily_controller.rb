class FeedGroups::Feeds::Items::DailyController < ApplicationController
  skip_before_action :authenticate
  before_action :set_date

  def show
    @default_feed_groups = FeedGroup.default
    @feed = Feed.find(params[:feed_id])
    @feed_group = FeedGroup.find(params[:feed_group_id])
    @feeds = @feed_group.feeds
    @items = @feed.items
                  .includes(:feed, :item_ogp)
                  .where(feed_id: @feed_group.feed_ids,
                         created_at: @date...(@date.next_day))
  end
end
