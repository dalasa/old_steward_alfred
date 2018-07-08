# frozen_string_literal: true

# This model describes an account
class Account < ActiveRecord::Base
  has_many :transactions
  enum kind: { checking: 0 }

  def credit(amount)
    self.total += amount
  end

  def debit(amount)
    self.total -= amount
  end
end