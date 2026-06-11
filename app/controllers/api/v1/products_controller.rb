class ProductsController < ApplicationController
  def index
    render json: Product.all
  end

  def create
    product = Product.new(product_params)
    if product.save
      render json: product
    else
      render json: product.errors, status: 422
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :sku, :stock, :price, :min_stock, :warehouse_id)
  end
end