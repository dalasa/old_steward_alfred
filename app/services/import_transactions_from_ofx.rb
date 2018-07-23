# frozen_string_literal: true

module Services
  # Service to import transactions from an Itau OFX file
  class ImportTransactionsFromOFX
    attr_reader :account_name
    def initialize(ofx_file, account_name)
      @ofx_file = ofx_file
      @account_name = account_name
    end

    def execute
      OFX(@ofx_file).account.transactions.map do |t|
        transaction = Adapters::TransactionAdapter.from_itau_ofx_transaction(t)
        create_transaction(transaction)
      end
    end

    private

    def create_transaction(transaction)
      Services::CreateTransaction.new(
        account_name: account_name,
        description: transaction.description,
        amount: transaction.amount,
        kind: transaction.kind,
        tags: transaction.tags,
        performed_at: transaction.performed_at.to_s
      ).execute
    end
  end
end
