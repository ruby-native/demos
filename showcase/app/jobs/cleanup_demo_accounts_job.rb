class CleanupDemoAccountsJob < ApplicationJob
  def perform
    User.demo_clones.where(created_at: ..2.days.ago).find_each(&:destroy)
  end
end
