# frozen_string_literal: true

require 'spec_helper'

RSpec.describe '/transaction' do
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
      post '/transaction', transaction
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
end
