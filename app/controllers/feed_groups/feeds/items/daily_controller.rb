class FeedGroups::Feeds::Items::DailyController < ApplicationController
  skip_before_action :authenticate
  before_action :set_date

  def show
    @feed = Feed.find(params[:feed_id])
    @feed_group = FeedGroup.find(params[:feed_group_id])
    @feeds = @feed_group.feeds
    @items = @feed.items
                  .includes(:feed, :item_ogp)
                  .where(feed_id: @feed_group.feed_ids,
                         created_at: @date...(@date.next_day))
  end

  private
    def set_date
      raise(AbstractController::ActionNotFound) unless params[:date].size == 8

      @date = Date.parse(params[:date]).to_time
    rescue Date::Error
      raise(AbstractController::ActionNotFound)
    end
end
