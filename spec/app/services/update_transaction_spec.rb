# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Services::UpdateTransaction do
  describe '#execute' do
    let(:initial_transaction_kind) { :expense }
    let(:account_starting_balance) { 100 }
    let(:account_name) { 'conta do banco' }
    let(:starting_transaction_ammount) { 50 }
    before do
      Services::CreateAccount.new(name: 'conta do banco', kind: :checking, balance: account_starting_balance).execute
    end
    let(:transaction) do
      Services::CreateTransaction.new(
        account_name: account_name,
        description: 'compra no mercado da esquina',
        amount: starting_transaction_ammount,
        kind: initial_transaction_kind,
        tags: %w[mercado alimentacao essencial],
        performed_at: Date.new.to_s
      ).execute
    end

    subject do
      described_class.new(transaction_id: transaction.id, attributes: attributes).execute
    end

    context 'when it updates transaction\'s description ' do
      let(:new_description) { 'a new description to this transaction' }
      let(:attributes) { { description:  new_description } }

      it 'successfully updates transaction\'s description' do
        subject
        expect(Transaction.find(transaction.id).description).to eq new_description
      end
    end

    context 'when it updates transaction\'s tags' do
      let(:new_tags) { %w[new tags] }
      let(:attributes) { { tags:  new_tags } }

      it 'successfully updates transaction\'s tags' do
        subject
        expect(Transaction.find(transaction.id).tags).to eq new_tags
      end
    end

    context 'when it updates transaction\'s date' do
      let(:new_date) { Date.new - 2.days }
      let(:attributes) { { performed_at: new_date } }

      it 'successfully updates transaction\'s date' do
        subject
        expect(Transaction.find(transaction.id).performed_at).to eq new_date
      end
    end

    context 'when it updates transaction\'s account' do
      let(:new_account_name) { 'outra conta do banco' }
      let(:attributes) { { account_name: new_account_name } }

      before do
        Services::CreateAccount.new(name: new_account_name, kind: :checking, balance: 100).execute
      end

      it 'successfully updates transaction\'s account' do
        subject
        expect(Transaction.find(transaction.id).account.name).to eq new_account_name
      end

      it 'successfully resets old account balance' do
        subject
        expect(Account.find_by(name: account_name).balance).to eq account_starting_balance
      end

      it 'updates new account balance correctly' do
        subject
        expected_balance = account_starting_balance - starting_transaction_ammount
        expect(Account.find_by(name: new_account_name).balance).to eq expected_balance
      end

      context 'but when account to update doesn\'t exist' do
        let(:absent_account_name) { 'conta nao existente' }
        let(:attributes) { { account_name:  absent_account_name } }
        it 'throws a validation exception for account field' do
          expect { subject }.to raise_error('Validation failed: Account can\'t be blank')
        end
      end
    end

    context 'when it updates transaction\'s amount' do
      let(:new_amount) { 25 }
      let(:attributes) { { amount: new_amount } }

      it 'successfully updates transaction\'s amount' do
        subject
        expect(Transaction.find(transaction.id).amount).to eq new_amount
      end

      it 'updates account balance correctly' do
        subject
        expect(Account.find_by(name: account_name).balance).to eq(account_starting_balance - new_amount)
      end
    end

    context 'when it updates transaction\'s kind' do
      let(:new_kind) { 'income' }
      let(:attributes) { { kind:  new_kind } }
      let(:account_balance) { Account.find_by(name: account_name).balance }

      it 'successfully updates transaction\'s kind' do
        subject
        expect(Transaction.find(transaction.id).kind).to eq new_kind
      end

      it 'updates account balance correctly' do
        subject
        expect(account_balance).to eq(account_starting_balance + starting_transaction_ammount)
      end
    end
  end
end
