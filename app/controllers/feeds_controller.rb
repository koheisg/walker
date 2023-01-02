class FeedsController < ApplicationController
  skip_before_action :authenticate
  before_action :set_feed

  # GET /feeds/1 or /feeds/1.json
  def show
    @items = @feed.items.includes(:item_ogp).first(24)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end
end
