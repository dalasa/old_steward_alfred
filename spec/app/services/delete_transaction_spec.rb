# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Services::DeleteTransaction do
  describe '#execute' do
    let(:account_name) { 'conta do banco' }
    let(:account_starting_total) { 100 }
    let(:transaction) do
      Services::CreateTransaction.new(
        account_name: account_name,
        description: 'compra no mercado da esquina',
        amount: 50,
        kind: :expense,
        tags: %w[mercado alimentacao essencial],
        performed_at: Date.new.to_s
      ).execute
    end

    before do
      Services::CreateAccount.new(name: 'conta do banco', kind: :checking, total: account_starting_total).execute
    end

    subject do
      described_class.new(transaction_id: transaction.id).execute
    end

    it 'successfully deletes the transaction' do
      subject
      expect(Transaction.count).to eq 0
    end

    it 'updates accounts total' do
      subject
      expect(Account.find_by(name: account_name).total).to eq(account_starting_total)
    end
  end
end
