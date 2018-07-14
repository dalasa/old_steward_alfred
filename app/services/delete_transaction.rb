# frozen_string_literal: true

module Services
  # Service that updates a transaction
  class DeleteTransaction
    def initialize(transaction_id:)
      @transaction_id = transaction_id
    end

    def execute
      deleted_transaction = transaction.clone
      transaction.destroy
      deleted_transaction.account.undo_transaction_process(deleted_transaction)
    end

    private

    def transaction
      Transaction.find(@transaction_id)
    end
  end
end
