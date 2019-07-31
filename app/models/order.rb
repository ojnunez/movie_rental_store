# frozen_string_literal: true

class Order < ApplicationRecord
  # Keep a log of all orders fields
  audited

  # Relations
  belongs_to :user
  belongs_to :movie
  # Could be has many if the store becomes successful
  has_one :rent, dependent: :destroy

  # An enumerator would have been better, but the field type is string, so
  # we adapt, if we had a dropdown we would show this two options
  # enum sale_kind: [:rental, :purchase]
  SALE_KIND = {
    'rental' => I18n.t('activerecord.enum.order.sale_kind.rental'),
    'purchase' => I18n.t('activerecord.enum.order.sale_kind.purchase')
  }.freeze

  # Validations, all fields are required, sale price and quantity it has to be
  # a positive number
  validates :movie, :user, :quantity, :sale_kind, presence: true
  validates :quantity,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  # validates :sale_amount, numericality: { greater_than: 0 }

  # Addition of a custom validation for stock availability
  validate :check_availability

  # Callback to calculate the total sale amount for the order according to the
  # quantity
  before_create :calculate_total

  # Callback for lower the stock after an order
  # Callback to add a rental tracking for the order, if that order was a rental
  after_create :lower_stock, :add_rent_tracking

  private

  # We check if the movie has enough stock to process the order
  def check_availability
    if movie.present? && movie.stock < quantity
      errors.add(:quantity, "Sorry we don't have enough stock to process your
        order. Only (#{movie.stock} items available)")
    end
  end

  def calculate_total
    self.sale_amount = sale_kind == 'rental' ? quantity * movie.rent_price.to_f : quantity * movie.sale_price.to_f
  end

  def lower_stock
    # We update without callbacks
    movie.update_column(:stock, movie.stock - quantity)
  end

  def add_rent_tracking
    if sale_kind == 'rental'
      # Add rental tracking to the movie
      rental = Rent.new
      rental.order_id = id
      rental.start_date = Time.zone.now
      rental.save
    end
  end
end
