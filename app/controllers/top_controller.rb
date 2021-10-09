class TopController < ApplicationController
  def show
    if Current.user
      redirect_to home_path
    else
      redirect_to new_session_path
    end
  end
end
