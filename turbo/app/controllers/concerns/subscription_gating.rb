module SubscriptionGating
  FREE_LINK_LIMIT = 10

  private

  def require_subscription
    return if current_user.subscribed? || current_user.links.count < FREE_LINK_LIMIT

    render_paywall
  end

  def render_paywall
    @page_title = "Upgrade"
    @annual = PurchaseKit::Product.find("prod_66QRC52Q")
    @monthly = PurchaseKit::Product.find("prod_JX6FFJ4G")
    render "subscriptions/new"
  end
end
