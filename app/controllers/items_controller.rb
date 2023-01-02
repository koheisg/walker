class ItemsController < ApplicationController
  skip_before_action :authenticate

  def index
    @ref_time = Time.current.midnight
    @items_set = Set.new(Item.includes(:item_ogp).where(created_at: ...@ref_time).limit(100)).classify { |item| item.created_at.to_date }
  end
end
