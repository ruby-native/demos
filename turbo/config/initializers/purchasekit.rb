PurchaseKit.configure do |config|
  purchasekit = Rails.application.credentials.purchasekit

  config.api_key = purchasekit.api_key
  config.app_id = purchasekit.app_id
  config.webhook_secret = purchasekit.webhook_secret

  config.on(:subscription_created) do |event|
    user = User.find_by(id: event.customer_id)
    next unless user

    user.subscriptions.find_or_create_by!(subscription_id: event.subscription_id) do |sub|
      sub.status = "active"
      sub.store_product_id = event.store_product_id
    end
  end
end
