# frozen_string_literal: true

class RenameLikesCounterFromMovies < ActiveRecord::Migration[5.2]
  def change
    rename_column :movies, :likes_counter, :movie_likes_count
  end
end
