# frozen_string_literal: true

class Order < ApplicationRecord
  # Relations
  belongs_to :user
  belongs_to :movie
  has_one :rent # Could be has many if the store becomes successful

  # Validations, all fields are required, sale price and quantity it has to be
  # a positive number
  validates :movie, :user, :quantity, :sale_price, :sale_kind, presence: true
  validates :quantity,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :sale_price, numericality: { greater_than: 0 }

  # Addition of a custom validation for stock availability
  validate :check_availability

  # Callback for lower the stock after an order
  after_create :lower_stock

  private

  def check_availability
    if movie.present? && movie.stock < quantity
      errors.add(:quantity, "Sorry we don't have enough stock to process your
        order. Only (#{movie.stock} items available)")
    end
  end

  def lower_stock
    # We update without callbacks
    product.update_column(:stock, movie.stock - quantity)
  end
end
