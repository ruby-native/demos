class AdvanceOrderJob < ApplicationJob
  FLOW = %w[placed preparing ready completed].freeze

  def perform(order)
    return unless order.persisted?

    current_index = FLOW.index(order.status)
    return if current_index.nil? || current_index >= FLOW.length - 1

    next_status = FLOW[current_index + 1]
    order.update!(status: next_status)

    if next_status == "ready"
      send_ready_notification(order)
    end

    if next_status != "completed"
      self.class.set(wait: 5.seconds).perform_later(order)
    end
  end

  private

  def send_ready_notification(order)
    devices = order.user.push_devices
    return if devices.none?

    notification = ApplicationPushNotification.new(
      title: "Your order is ready! ☕",
      body: "Order ##{order.id} is waiting for you at the counter.",
      data: {path: "/orders/#{order.id}"}
    )
    notification.deliver_later_to(devices)
  end
end
