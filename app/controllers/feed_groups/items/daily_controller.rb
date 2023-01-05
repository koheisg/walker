class FeedGroups::Items::DailyController < ApplicationController
  skip_before_action :authenticate
  before_action :set_date

  def show
    @feed_group = FeedGroup.find(params[:feed_group_id])
    @feeds = @feed_group.feeds
    @items = Item.includes(:feed, :item_ogp)
                 .where(feed_id: @feed_group.feed_ids,
                        created_at: @date...(@date.next_day))
  end
end
