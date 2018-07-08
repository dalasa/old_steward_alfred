# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Account do
  describe '#process_transaction' do
    subject do
      account = Account.new(name: 'conta do banco', kind: 'checking', total: account_starting_total)
      account.save!
      account.process_transaction(transaction)
    end
    context 'when it is a checking account' do
      let(:account_starting_total) { 100 }
      let(:account_name) { 'conta do banco' }
      let(:transaction) do
        Transaction.new({
          account: Account.find_by(name: account_name),
          description: 'compra no mercado da esquina',
          amount: 100,
          kind: transaction_kind,
          tags: %w[mercado alimentacao essencial],
          transaction_date: Date.new.to_s
        })
      end

      context 'when a income transaction is added to account' do
        let(:transaction_kind) { :income }

        it 'sums the transaction amount to accounts total' do
          subject
          expect(Account.find_by(name: account_name).total).to eq(account_starting_total + transaction.amount)
        end
      end

      context 'when a expense transaction is added to account' do
        let(:transaction_kind) { :expense }
        it 'substracts the amount from accounts total' do
          subject
          expect(Account.find_by(name: account_name).total).to eq(account_starting_total - transaction.amount)
        end
      end
    end
  end
end
