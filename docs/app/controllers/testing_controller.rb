# Exercises native integrations that have no home on a recording page. CI UI
# tests reach it through the env-gated link on the profile page. Keep new
# test-only surfaces under this namespace so recordings never see them.
class TestingController < ApplicationController
  def index
  end
end
