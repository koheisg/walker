class ApplicationController < ActionController::Base
  include Authentication
  include SetCurrentRequestDetails
  include DateableParams
end
