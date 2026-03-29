RubyNative.on_subscription_change do |event|
  user = User.find_by(id: event.owner_token)
  next unless user

  if event.active?
    subscription = user.subscription || user.build_subscription
    subscription.update!(
      product_id: event.product_id,
      original_transaction_id: event.original_transaction_id,
      status: event.status,
      expires_at: event.expires_date
    )
  elsif event.expired?
    user.subscription&.update!(status: "expired")
  end
end
