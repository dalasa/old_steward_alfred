# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Services::CreateTransaction do
  describe '#execute' do
    let(:account_name) { 'conta do banco' }
    let(:transaction_kind) { :expense }
    let(:transaction) do
      {
        account_name: account_name,
        description: 'compra no mercado da esquina',
        amount: 50,
        kind: transaction_kind,
        tags: %w[mercado alimentacao essencial],
        performed_at: Date.new.to_s
      }
    end
    subject do
      described_class.new(transaction).execute
    end

    context 'when account does not exists,' do
      it 'raise ActiveRecord::RecordInvalid exception' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
      it 'throws a validation exception for account field' do
        expect { subject }.to raise_error('Validation failed: Account can\'t be blank')
      end
    end

    context 'when account exists' do
      let(:account_starting_balance) { 100 }

      before do
        Services::CreateAccount.new(name: 'conta do banco', kind: :checking, balance: account_starting_balance).execute
      end

      it 'successfully creates a transaction' do
        subject
        expect(Transaction.count).to eq 1
      end

      it 'returns the created transaction' do
        expect(subject).to be_a(Transaction)
      end

      context 'when it is an expense transaction' do
        let(:transaction_kind) { 'expense' }
        it 'substracts the amount from accounts balance' do
          transaction = subject
          expect(Account.find_by(name: account_name).balance).to eq(account_starting_balance - transaction.amount)
        end
      end

      context 'when it is an income transaction' do
        let(:transaction_kind) { :income }
        it 'sums the transaction amount to accounts balance' do
          transaction = subject
          expect(Account.find_by(name: account_name).balance).to eq(account_starting_balance + transaction.amount)
        end
      end
    end
  end
end
