# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.datetime :order_date
      t.references :user
      t.references :movie
      t.string :sale_kind
      t.integer :quantity
      t.decimal :sale_amount, precision: 8, scale: 2
      t.timestamps
    end
  end
end
