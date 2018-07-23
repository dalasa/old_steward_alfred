# frozen_string_literal: true

require 'spec_helper'

RSpec.describe '/files' do
  before do
    setup_api_authorization
  end

  describe '/ofx' do
    describe '#post' do
      context 'ofx file upload for importing transactions' do
        subject do
          post '/files/ofx',
               data: Rack::Test::UploadedFile.new('spec/resources/example.ofx', 'text/plain'),
               account_name: account.name
        end

        before { subject }

        context 'when successfully' do
          let(:account) { Services::CreateAccount.new(name: 'conta_teste', kind: :checking, balance: 100).execute }

          it 'returns 200 status' do
            expect(last_response.status).to eq 200
          end

          it 'creates the file\'s 5 transactions on account' do
            expect(account.transactions.size).to eq 5
          end

          it 'updates the account balance' do
            expect(account.reload.balance).to eq 825.24
          end

          let(:transaction_keys) do
            %w[id account_id description amount kind tags performed_at billing_date created_at updated_at]
          end
          it 'returns the created transactions' do
            expect(Oj.load(last_response.body).first.keys).to contain_exactly(*transaction_keys)
          end
        end
      end
    end
  end
end
