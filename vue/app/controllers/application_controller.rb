class ApplicationController < ActionController::Base
  include Authentication
  include InertiaSharedData

  before_action :authenticate_user!
  allow_browser versions: :modern
end
