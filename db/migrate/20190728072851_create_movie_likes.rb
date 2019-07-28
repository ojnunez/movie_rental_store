# frozen_string_literal: true

class CreateMovieLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_likes do |t|
      t.references :movie, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
