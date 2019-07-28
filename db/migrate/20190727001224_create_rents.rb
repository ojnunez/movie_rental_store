# frozen_string_literal: true

class CreateRents < ActiveRecord::Migration[5.2]
  def change
    create_table :rents do |t|
      t.references :order
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :penalty
      t.timestamps
    end
  end
end
