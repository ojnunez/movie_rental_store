# frozen_string_literal: true

class AddLikesCounterToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :likes_counter, :integer, default: 0, index: true
  end
end
