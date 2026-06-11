class Api::V1::DashboardController < ApplicationController
  def index
    render json: {
      top_products: Product.order(stock: :desc).limit(5),
      low_stock: Product.where("stock < min_stock"),
      recent_activities: StockMovement.includes(:product)
                                      .order(created_at: :desc)
                                      .limit(10),
      warehouse_summary: Warehouse.includes(:products).map do |w|
        {
          name: w.name,
          total_stock: w.products.sum(:stock)
        }
      end,
      health_score: health_score
    }
  end

  private

  def health_score
    total = Product.count
    return 0 if total.zero?

    safe = Product.where("stock >= min_stock").count
    (safe.to_f / total * 100).round(2)
  end
end