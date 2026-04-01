class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  enum :status, {cart: "cart", placed: "placed", preparing: "preparing", ready: "ready", completed: "completed"}

  scope :active, -> { where(status: [:placed, :preparing, :ready]) }
  scope :past, -> { where(status: :completed) }

  def active?
    placed? || preparing? || ready?
  end

  def recalculate_total!
    update!(total: order_items.sum { |item| item.line_total })
  end

  def display_total
    "$#{"%.2f" % (total / 100.0)}"
  end

  def status_label
    case status
    when "cart" then "In cart"
    when "placed" then "Placed"
    when "preparing" then "Preparing"
    when "ready" then "Ready for pickup"
    when "completed" then "Completed"
    end
  end
end
