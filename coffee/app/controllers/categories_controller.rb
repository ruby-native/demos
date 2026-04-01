class CategoriesController < ApplicationController
  def index
    render inertia: "Categories/Index", props: {
      categories: Category.all.map { |c|
        {id: c.id, name: c.name, description: c.description, image_url: image_url(c.image_url), products_count: c.products.size}
      }
    }
  end

  def show
    category = Category.find(params[:id])
    render inertia: "Categories/Show", props: {
      category: {id: category.id, name: category.name, description: category.description},
      products: category.products.map { |p|
        {id: p.id, name: p.name, description: p.description, base_price: p.base_price, display_price: p.display_price, image_url: image_url(p.image_url), category_id: category.id}
      }
    }
  end

  private

  def image_url(path)
    path.present? ? helpers.asset_path(path) : nil
  end
end
