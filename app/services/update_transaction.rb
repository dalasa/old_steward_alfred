# frozen_string_literal: true

module Services
  # Service that updates a transaction
  class UpdateTransaction
    def initialize(transaction_id:, attributes:)
      @transaction_id = transaction_id
      @attributes = attributes
    end

    def execute
      old_transaction = transaction.clone
      update_transaction_on_database
      fix_account_balance(old_transaction) if %i[amount kind account].any? { |k| @attributes.key?(k) }
    end

    private

    def update_transaction_on_database
      add_account_to_update_attributes if @attributes.key?(:account_name)
      transaction.update!(@attributes)
    end

    def add_account_to_update_attributes
      new_account_name = @attributes.delete(:account_name)
      @attributes[:account] = new_account(new_account_name) unless new_account_name.nil?
    end

    def transaction
      Transaction.find(@transaction_id)
    end

    def new_account(name)
      Account.find_by(name: name)
    end

    def fix_account_balance(old_transaction)
      old_transaction.account.undo_transaction_process(old_transaction)
      transaction.account.process_transaction(transaction)
    end
  end
end
