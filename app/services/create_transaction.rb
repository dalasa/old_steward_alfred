# frozen_string_literal: true

module Services
  # Service that creates a transaction
  class CreateTransaction
    def initialize(account_name:, description:, amount:, kind:, tags:, performed_at:)
      @account_name = account_name
      @description = description
      @amount = amount
      @kind = kind
      @tags = tags
      @performed_at = Date.parse(performed_at)
    end

    def execute
      transaction = create_on_database
      update_account_total_with(transaction)
      transaction
    end

    private

    def account
      @account ||= Account.find_by(name: @account_name)
    end

    def update_account_total_with(transaction)
      account.process_transaction(transaction)
    end

    def create_on_database
      Transaction.create!(
        account: account,
        description: @description,
        amount: @amount,
        kind: @kind,
        tags: @tags,
        performed_at: @performed_at,
        billing_date: @performed_at
      )
    end
  end
end
