# frozen_string_literal: true

class Rent < ApplicationRecord
  # Relations
  belongs_to :order

  # Validations
  validates :start_date, :end_date, presence: true

  # Callback to calculate the date that the movie has to be returned

  after_create :calculate_due_date

  private

  def calculate_due_date
    # If the admin forgets to set the default days permitted for rent a movie,
    # we set a default of 3 days
    setting = RentalSetting.first
    if setting.blank? || (setting.default_rental_days <= 0)
      update_column(:end_date, (start_date +
        setting.default_rental_days.to_i.days).end_of_day)
    else
      update_column(:end_date, (start_date + 3.days).end_of_day)
    end
  end

  def return_rented_item
    # We check if the item was returned on time, if that so, we update the row
    update_column(:penalty, true) if Time.zone.now > end_date
  end
end
