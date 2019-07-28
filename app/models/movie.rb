# frozen_string_literal: true

class Movie < ApplicationRecord
  # Keep a log of sale and rent price each time we update
  audited only: %i[sale_price rent_price], on: [:update]

  # Attach an image with the help of ActiveStorage
  has_one_attached :cover

  # Validations for required fields
  validates :title, :stock, :rent_price, :sale_price, presence: true
  validates :stock,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than: 0 }

  def cover_image_url
    # Validate if there is a cover image attached to a movie, return a
    # blank string if there's not
    cover.attached? ? Rails.application.routes.url_helpers.rails_blob_url(image) : ''
  end
end
