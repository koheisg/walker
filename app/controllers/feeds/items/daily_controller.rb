class Feeds::Items::DailyController < ApplicationController
  skip_before_action :authenticate
  before_action :set_date

  def show
    @feed = Feed.find(params[:feed_id])
    @items = @feed.items.includes(:item_ogp).where(created_at: @date...(@date.next_day))
  end
end
