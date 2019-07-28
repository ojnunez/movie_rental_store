# frozen_string_literal: true

class RentalSetting < ApplicationRecord
  # Manageable settings for rentals policies

  # All of this model's attributes are required
  validates :default_rental_days, :default_penalty_amount, presence: true

  validates :default_rental_days,
            numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :default_penalty_amount, numericality: { greater_than: 0 }
end
