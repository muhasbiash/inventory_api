class Warehouse < ApplicationRecord
  has_many :products
  has_many :stock_movements

  validates :name, presence: true

  def products_count
    products.count
  end

  def total_stock
    products.sum(:stock)
  end
end