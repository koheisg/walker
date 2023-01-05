class ApplicationController < ActionController::Base
  include Authentication
  include SetCurrentRequestDetails
  include DateableParams

  PER_PAGE = [12, 36, 72, 144].freeze
end
