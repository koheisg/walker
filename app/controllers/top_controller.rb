class TopController < ApplicationController
  def show
    @date = Date.today
    @items = Item.includes(:item_ogp, :feed).where(feed: Feed.default).first(10)
  end
end
