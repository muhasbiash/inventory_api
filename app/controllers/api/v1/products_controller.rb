class Api::V1::ProductsController < ApplicationController
  def index
    products = Product.includes(:warehouse)

    render json: products.as_json(
      include: {
        warehouse: {
          only: [:id, :name]
        }
      }
    )
  end

  def show
    product = Product.find(params[:id])

    render json: product.as_json(
      include: {
        warehouse: {
          only: [:id, :name]
        }
      }
    )
  end

  def create
    product = Product.new(product_params)

    if product.save
      render json: product, status: :created
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    product = Product.find(params[:id])

    if product.update(product_params)
      render json: product
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find(params[:id])

    product.destroy

    render json: {
      message: "Product deleted successfully"
    }
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :sku,
      :stock,
      :price,
      :min_stock,
      :warehouse_id
    )
  end
end