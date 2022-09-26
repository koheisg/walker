class Feeds::ItemsController < ApplicationController
  skip_before_action :authenticate

  def index
    @feed = Feed.find(params[:feed_id])
    @ref_time = Time.current.midnight
    @items_set = Set.new(@feed.items.includes(:item_ogp).where(created_at: ...@ref_time).limit(100)).classify { |item| item.created_at.to_date }
  end
end
