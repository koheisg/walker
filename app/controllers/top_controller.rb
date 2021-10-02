class TopController < ApplicationController
  skip_before_action :authenticate

  def show
    if Current.user
      redirect_to feeds_path
    else
      redirect_to new_session_path
    end
  end
end
