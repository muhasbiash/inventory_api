class StockMovementsController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      movement = StockMovement.create!(movement_params)
      product = movement.product

      if movement.in?
        product.stock += movement.quantity
      else
        product.stock -= movement.quantity
      end

      product.save!

      render json: movement
    end
  end

  def index
    render json: StockMovement.includes(:product).order(created_at: :desc)
  end

  private

  def movement_params
    params.require(:stock_movement).permit(:product_id, :warehouse_id, :quantity, :movement_type)
  end
end