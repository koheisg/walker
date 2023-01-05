class Items::WeeklyController < ApplicationController
  skip_before_action :authenticate
  before_action :set_date

  def show
    @items = Item.includes(:item_ogp, :feed).where(created_at: (@date.weeks_ago(1))...(@date.next_day))
  end
end
