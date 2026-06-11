class Warehouse < ApplicationRecord
  has_many :products
  has_many :stock_movements
end