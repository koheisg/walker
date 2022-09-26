class TopController < ApplicationController
  skip_before_action :authenticate
  def show
    @date = Date.today
    @items = Item.includes(:item_ogp, :feed).where(feed: Feed.default).first(24)
  end
end
