class Items::DailyController < ApplicationController
  skip_before_action :authenticate
  before_action :set_date

  def show
    @items = Item.includes(:item_ogp, :feed).where(created_at: @date...(@date.next_day))
  end
end
