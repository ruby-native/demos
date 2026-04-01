class ProductsController < ApplicationController
  def show
    category = Category.find(params[:category_id])
    product = category.products.find(params[:id])
    render inertia: "Products/Show", props: {
      product: {
        id: product.id,
        name: product.name,
        description: product.description,
        base_price: product.base_price,
        display_price: product.display_price,
        image_url: product.image_url.present? ? helpers.asset_path(product.image_url) : nil,
        category_id: category.id,
        category_name: category.name,
        is_pastry: category.name == "Pastries"
      },
      size_adjustments: Product::SIZE_ADJUSTMENTS,
      extras: [
        {name: "Vanilla syrup", price: 70},
        {name: "Caramel drizzle", price: 70},
        {name: "Extra shot", price: 80},
        {name: "Whipped cream", price: 50}
      ]
    }
  end
end
