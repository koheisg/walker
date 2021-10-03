class Feeds::ItemsController < ApplicationController
  skip_before_action :authenticate

  def index
    @feed = Feed.find(params[:feed_id])
    @items_set = Set.new(@feed.items.where(created_at: ...Time.current.midnight).limit(100)).classify { |item| item.created_at.to_date }
  end
end
