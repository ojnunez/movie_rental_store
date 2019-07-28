# frozen_string_literal: true

class MovieLike < ApplicationRecord
  belongs_to :movie, counter_cache: true
  belongs_to :user

  # Validate the associations
  validates :user, :movie, presence: true
  # Validate that the user can only give one like to a movie
  validates :user_id, uniqueness: { scope: :movie_id, message: 'You already like this movie' }
end
