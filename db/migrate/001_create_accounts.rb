# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[5.1]
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.column :kind, :integer, default: 0
      t.float :total
      t.timestamps null: false
    end
    add_index('accounts', 'name', unique: true)
  end

  def self.down
    drop_table :accounts
  end
end
