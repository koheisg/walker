class Feeds::Items::WeeklyController < ApplicationController
  skip_before_action :authenticate
  before_action :set_date

  def show
    @feed = Feed.find(params[:feed_id])
    @items = @feed.items.includes(:item_ogp).where(created_at: (@date.weeks_ago(1))...(@date.next_day))
  end
end
