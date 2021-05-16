class TopController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    if current_user
      redirect_to feeds_path
    else
      redirect_to new_user_session_path
    end
  end
end
