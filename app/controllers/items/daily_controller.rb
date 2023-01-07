class Items::DailyController < ApplicationController
  skip_before_action :authenticate
  before_action :set_date

  def show
    @default_feed_groups = FeedGroup.default
    set_page_and_extract_portion_from(
      Item.includes(:item_ogp, :feed)
          .where(created_at: @date...(@date.next_day))
          .order(created_at: :desc),
      per_page: PER_PAGE
    )
  end
end
