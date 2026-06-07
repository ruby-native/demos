class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :books, dependent: :destroy

  # Throwaway accounts minted by "Explore the demo" (demo<digits>@example.com),
  # excluding the seeded source account. Swept by CleanupDemoAccountsJob.
  scope :demo_clones, -> { where("email_address LIKE 'demo%@example.com'").where.not(email_address: "demo@example.com") }

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
