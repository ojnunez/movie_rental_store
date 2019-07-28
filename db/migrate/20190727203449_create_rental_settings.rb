# frozen_string_literal: true

class CreateRentalSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :rental_settings do |t|
      t.integer :default_rental_days
      t.decimal :default_penalty_amount, precision: 8, scale: 2
      t.timestamps
    end
  end
end
