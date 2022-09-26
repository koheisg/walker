class HomeController < ApplicationController
  def show
  end

  helper_method :date
  def date(date=Time.current)
    date.strftime("%Y%m%d")
  end
end
