class Api::V1::StockMovementsController < ApplicationController
  def index
    movements = StockMovement
                  .includes(:product, :warehouse)
                  .order(created_at: :desc)

    render json: movements.as_json(
      include: {
        product: {
          only: [:id, :name, :sku]
        },
        warehouse: {
          only: [:id, :name]
        }
      }
    )
  end

  def create
    ActiveRecord::Base.transaction do
      movement = StockMovement.create!(movement_params)
      product = movement.product

      if movement.out? && product.stock < movement.quantity
        render json: {
          error: "Insufficient stock"
        }, status: :unprocessable_entity

        raise ActiveRecord::Rollback
      end

      new_stock =
        if movement.in?
          product.stock + movement.quantity
        else
          product.stock - movement.quantity
        end

      product.update!(stock: new_stock)

      render json: movement, status: :created
    end
  end

  private

  def movement_params
    params.require(:stock_movement).permit(
      :product_id,
      :warehouse_id,
      :quantity,
      :movement_type
    )
  end
end