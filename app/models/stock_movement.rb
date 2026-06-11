class StockMovement < ApplicationRecord
  belongs_to :product
  belongs_to :warehouse

  enum movement_type: { in: 0, out: 1 }
end
