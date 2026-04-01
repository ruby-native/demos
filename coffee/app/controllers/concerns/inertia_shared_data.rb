module InertiaSharedData
  extend ActiveSupport::Concern

  included do
    inertia_share do
      {
        flash: {notice: flash.notice, alert: flash.alert},
        current_user: current_user&.slice(:id, :email, :name),
        user_signed_in: user_signed_in?,
        cart_count: user_signed_in? ? current_cart.order_items.count : 0,
        title: @page_title
      }
    end
  end

  private

  def current_cart
    @current_cart ||= current_user.orders.find_or_create_by!(status: :cart)
  end
end
