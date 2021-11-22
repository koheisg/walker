class Feeds::Items::DailyController < ApplicationController
  skip_before_action :authenticate
  before_action :set_date

  def show
    @feed = Feed.find(params[:feed_id])
    set_page_and_extract_portion_from(@feed.items.includes(:item_ogp).where(created_at: @date...(@date.next_day)),
                                      per_page: [12, 36, 72, 144])
  end

  private
    def set_date
      raise(AbstractController::ActionNotFound) unless params[:date].size == 8

      @date = Date.parse(params[:date]).to_time
    rescue Date::Error
      raise(AbstractController::ActionNotFound)
    end
end
