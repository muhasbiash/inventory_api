class Api::V1::WarehousesController < ApplicationController

  def index
    warehouses = Warehouse.all

    render json: warehouses.as_json(
      methods: [
        :products_count,
        :total_stock
      ]
    )
  end

  def show
    warehouse = Warehouse.find(params[:id])

    render json: warehouse.as_json(
      methods: [
        :products_count,
        :total_stock
      ]
    )
  end

  def create
    warehouse = Warehouse.new(warehouse_params)

    if warehouse.save
      render json: warehouse, status: :created
    else
      render json: {
        errors: warehouse.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    warehouse = Warehouse.find(params[:id])

    if warehouse.update(warehouse_params)
      render json: warehouse
    else
      render json: {
        errors: warehouse.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    warehouse = Warehouse.find(params[:id])
    warehouse.destroy

    head :no_content
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(
      :name,
      :address
    )
  end
end