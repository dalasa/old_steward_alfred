# frozen_string_literal: true

class Transaction < ActiveRecord::Base
  belongs_to :account
  validates :account, presence: true
  enum kind: { expense: 0, income: 1 }
end
