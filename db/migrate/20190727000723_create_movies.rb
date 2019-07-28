# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.boolean :availability, default: false
      t.string :title
      t.text :description
      t.integer :stock
      t.decimal :rent_price, precision: 8, scale: 2
      t.decimal :sale_price, precision: 8, scale: 2
      t.timestamps
    end
  end
end
