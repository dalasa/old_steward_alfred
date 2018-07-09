# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[5.1]
  def self.up
    create_table :transactions do |t|
      t.belongs_to :account, index: true
      t.string :description, null: false
      t.float :amount, null: false
      t.column :kind, :integer, default: 0
      t.string :tags, array: true, default: []
      t.date :performed_at, null: false
      t.date :billing_date, null: false
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :transactions
  end
end
