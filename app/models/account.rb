# frozen_string_literal: true

# This model describes an account
class Account < ActiveRecord::Base
  has_many :transactions
  enum kind: { checking: 0 }

  def process_transaction(transaction)
    credit(transaction.amount) if transaction.income?
    debit(transaction.amount) if transaction.expense?
    self.save!
  end

  private

  def credit(amount)
    self.total += amount
  end

  def debit(amount)
    self.total -= amount
  end
end
