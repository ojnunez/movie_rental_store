# frozen_string_literal: true

class Rent < ApplicationRecord
  # Relations
  belongs_to :order

  # Validations
  validates :start_date, presence: true

  # Callback to calculate the date that the movie has to be returned

  after_create :calculate_due_date

  def return_rented_item
    # We check if the item was returned on time, if that so, we update the row
    # and add a penalty to the user
    if Time.zone.now > end_date
      setting = RentalSetting.first
      penalty_amount = if !setting.nil? || (setting.default_penalty_amount > 0)
                         setting.default_penalty_amount.to_f
                       else
                         '3.99'.to_f
                       end
      update_columns(penalty: true, penalty_amount: penalty_amount)
    else
      update_columns(penalty: false, penalty_amount: 0)
    end
  end

  private

  def calculate_due_date
    # If the admin forgets to set the default days permitted for rent a movie,
    # we set a default of 3 days
    setting = RentalSetting.first
    if !setting.nil? || (setting.default_rental_days > 0)
      update_column(:end_date, (start_date + 3.days).end_of_day)
    else
      update_column(:end_date, (start_date +
        setting.default_rental_days.to_i.days).end_of_day)
    end
  end
end
