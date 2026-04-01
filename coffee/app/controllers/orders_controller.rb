class OrdersController < ApplicationController
  def index
    render inertia: "Orders/Index", props: {
      active_orders: current_user.orders.active.order(placed_at: :desc).map { |o| order_props(o) },
      past_orders: current_user.orders.past.order(placed_at: :desc).map { |o| order_props(o) }
    }
  end

  def show
    order = current_user.orders.find(params[:id])
    render inertia: "Orders/Show", props: {
      order: order_props(order),
      items: order.order_items.includes(:product, :order_item_extras).map { |item|
        {
          id: item.id,
          product_name: item.product.name,
          quantity: item.quantity,
          customization_summary: item.customization_summary,
          display_line_total: item.display_line_total
        }
      }
    }
  end

  def create
    cart = current_cart
    if cart.order_items.empty?
      redirect_to cart_path
      return
    end

    cart.recalculate_total!
    cart.update!(status: :placed, placed_at: Time.current)

    points = (cart.total / 100.0).ceil
    current_user.reward_activities.create!(
      description: "Order ##{cart.id}",
      points: points
    )
    current_user.increment!(:reward_points, points)

    AdvanceOrderJob.set(wait: 5.seconds).perform_later(cart)

    @current_cart = nil

    redirect_to order_path(cart)
  end

  private

  def order_props(order)
    {
      id: order.id,
      status: order.status,
      status_label: order.status_label,
      display_total: order.display_total,
      placed_at: order.placed_at&.strftime("%b %-d, %Y at %-I:%M %p"),
      items_count: order.order_items.size,
      active: order.active?
    }
  end
end
