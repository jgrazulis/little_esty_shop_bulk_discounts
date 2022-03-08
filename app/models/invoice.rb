class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def discount_items
    invoice_items.joins(:bulk_discounts)
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .select("invoice_items.*, bulk_discounts.id as discount, max(invoice_items.unit_price * invoice_items.quantity * (bulk_discounts.percentage_discount / 100.0)) as total_discount")
    .group("invoice_items.id, discount")
    .order(total_discount: :desc)
  end

  def total_discount
    invoice_items.joins(:bulk_discounts)
    .select("invoice_items.*, max(invoice_items.unit_price * invoice_items.quantity * (bulk_discounts.percentage_discount / 100.0)) as total_discount")
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .group("invoice_items.id")
    .order(total_discount: :desc)
    .sum(&:total_discount)
  end

  def total_discounted_revenue
    (invoice_items.sum("unit_price * quantity")) - (total_discount)
  end
end
