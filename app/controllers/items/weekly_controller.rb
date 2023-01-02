class Items::WeeklyController < ApplicationController
  skip_before_action :authenticate
  before_action :set_date

  def show
    @items = Item.includes(:item_ogp, :feed).where(created_at: (@date.weeks_ago(1))...(@date.next_day))
  end

  private
    def set_date
      raise(AbstractController::ActionNotFound) unless params[:date].size == 8

      @date = Date.parse(params[:date]).to_time
    rescue Date::Error
      raise(AbstractController::ActionNotFound)
    end
end
