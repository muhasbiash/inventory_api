class Product < ApplicationRecord
  belongs_to :warehouse
  has_many :stock_movements

  def low_stock?
    stock < min_stock
  end
end