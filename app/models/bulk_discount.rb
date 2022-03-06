class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :percentage_discount, numericality: true
  validates_presence_of :quantity_threshold, numericality: true 
end
