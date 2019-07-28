# frozen_string_literal: true

class AddPenaltyAmountToRents < ActiveRecord::Migration[5.2]
  def change
    add_column :rents, :penalty_amount, :decimal, precision: 8, scale: 2
  end
end
