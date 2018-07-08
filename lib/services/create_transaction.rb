# frozen_string_literal: true

module Services
  # Service that creates a transaction
  class CreateTransaction
    def initialize(account_name:, description:, amount:, kind:, tags:, transaction_date:)
      @account_name = account_name
      @description = description
      @amount = amount
      @kind = kind
      @tags = tags
      @transaction_date = Date.parse(transaction_date)
    end

    def execute
      transaction = Transaction.create!(
        account: account,
        description: @description,
        amount: @amount,
        kind: @kind,
        tags: @tags,
        transaction_date: @transaction_date,
        billing_date: @transaction_date + 1.day
      )
      update_account(transaction)
      transaction
    end

    private

    def account
      @account ||= Account.find_by(name: @account_name)
    end

    def update_account(transaction)
      account.credit(transaction.amount) if transaction.income?
      account.debit(transaction.amount) if transaction.expense?
      account.save!
    end
  end
end
