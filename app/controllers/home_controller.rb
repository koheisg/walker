class HomeController < ApplicationController
  def show
    set_page_and_extract_portion_from Item.includes(:feed, :item_ogp).all
  end
end
