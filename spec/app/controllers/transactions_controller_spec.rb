# frozen_string_literal: true

require 'spec_helper'

RSpec.describe '/transactions' do
  describe '#post' do
    let(:transaction) do
      {
        account_name: 'conta do banco',
        description: 'compra no mercado da esquina',
        amount: 100,
        kind: 'expense',
        tags: %w[mercado alimentacao essencial],
        transaction_date: Date.new.to_s
      }
    end
    subject do
      post '/transactions', transaction
    end

    context 'when account does not exist' do
      it 'returns 500' do
        subject
        expect(last_response.status).to eq 500
      end
    end

    context 'when accoutn exists' do
      before do
        Services::CreateAccount.new(name: 'conta do banco', kind: :checking, total: 100).execute
      end

      it 'returns 201' do
        subject
        expect(last_response.status).to eq 201
      end

      it 'returns a transaction' do
        subject
        expect(Oj.load(last_response.body)).to have_key('description')
      end
    end
  end

  describe '#patch' do
    subject do
      patch "/transactions/#{transaction.id}", attributes_to_update
    end

    before do
      Services::CreateAccount.new(name: 'conta do banco', kind: :checking, total: 100).execute
    end

    let(:transaction) do
      Services::CreateTransaction.new(
        account_name: 'conta do banco',
        description: 'compra no mercado da esquina',
        amount: 100,
        kind: :expense,
        tags: %w[mercado alimentacao essencial],
        transaction_date: Date.new.to_s
      ).execute
    end

    context 'when it updates some field like description' do
      let(:attributes_to_update) { { description: 'new description' } }

      it 'returns a 200 code' do
        subject
        expect(last_response.status).to eq 200
      end
    end
  end

  describe '#delete' do
    subject do
      delete "/transactions/#{transaction.id}"
    end

    before do
      Services::CreateAccount.new(name: 'conta do banco', kind: :checking, total: 100).execute
    end

    let(:transaction) do
      Services::CreateTransaction.new(
        account_name: 'conta do banco',
        description: 'compra no mercado da esquina',
        amount: 100,
        kind: :expense,
        tags: %w[mercado alimentacao essencial],
        transaction_date: Date.new.to_s
      ).execute
    end

    context 'when it deletes an existing transaction' do
      it 'returns a 200 code' do
        subject
        expect(last_response.status).to eq 200
      end

      it 'deletes the transaction' do
        subject
        expect { Transaction.find(transaction.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#get' do
    subject do
      get "/transactions/#{transaction.id}"
    end

    before do
      Services::CreateAccount.new(name: 'conta do banco', kind: :checking, total: 100).execute
    end

    let(:transaction) do
      Services::CreateTransaction.new(
        account_name: 'conta do banco',
        description: 'compra no mercado da esquina',
        amount: 100,
        kind: :expense,
        tags: %w[mercado alimentacao essencial],
        transaction_date: Date.new.to_s
      ).execute
    end

    context 'when it deletes an existing transaction' do
      it 'returns a 200 code' do
        subject
        expect(last_response.status).to eq 200
      end

      it 'returns requested transaction' do
        subject
        expect(last_response.body).to eq transaction.to_json
      end
    end
  end
end
