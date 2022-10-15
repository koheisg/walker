class FeedGroups::ItemsController < ApplicationController
  skip_before_action :authenticate

  def index
    @feed_group = FeedGroup.find(params[:feed_group_id])
    @ref_time = Time.current.midnight
    @items_set = Set.new(
      Item.includes(:feed, :item_ogp).where(feed_id: @feed_group.feed_ids, created_at: ...@ref_time).limit(100)
    ).classify { |item| item.created_at.to_date }
  end
end
