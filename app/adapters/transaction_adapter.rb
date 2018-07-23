# frozen_string_literal: true

# module for ower adapters pattern layer
module Adapters
  # this class always conver something to Alfred Transaction
  class TransactionAdapter
    class << self
      def from_itau_ofx_transaction(itau_ofx_transaction)
        Transaction.new(
          description: itau_ofx_transaction.memo,
          amount: convert_amount(itau_ofx_transaction.amount),
          kind: convert_kind(itau_ofx_transaction.type),
          tags: [],
          performed_at: convert_date(itau_ofx_transaction.posted_at),
          billing_date: convert_date(itau_ofx_transaction.posted_at)
        )
      end

      private

      def convert_kind(itau_transaction_type)
        return 'expense' if itau_transaction_type.eql? :debit
        return 'income' if itau_transaction_type.eql? :credit
      end

      def convert_date(time)
        time.to_datetime.to_date
      end

      # FIXME: remove this because float is not the best type to use here
      def convert_amount(amount)
        amount.abs.to_f
      end
    end
  end
end
