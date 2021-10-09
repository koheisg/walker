class HomeController < ApplicationController
  def show
    set_page_and_extract_portion_from Item.all
  end
end
