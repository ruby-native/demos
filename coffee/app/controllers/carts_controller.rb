class CartsController < ApplicationController
  def show
    cart = current_cart
    render inertia: "Carts/Show", props: {
      items: cart.order_items.includes(:product, :order_item_extras).map { |item|
        {
          id: item.id,
          product_name: item.product.name,
          quantity: item.quantity,
          size: item.size,
          milk: item.milk,
          customization_summary: item.customization_summary,
          display_line_total: item.display_line_total
        }
      },
      display_total: cart.display_total,
      empty: cart.order_items.empty?
    }
  end
end
