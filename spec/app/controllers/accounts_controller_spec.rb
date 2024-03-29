# frozen_string_literal: true

require 'spec_helper'

RSpec.describe '/accounts' do
  before do
    setup_api_authorization
  end

  describe '#post' do
    let(:account) do
      {
        name: 'my bank checking account',
        kind: 'checking',
        balance: 100
      }
    end
    subject do
      post '/accounts', account.to_json, 'CONTENT_TYPE' => 'application/json'
    end

    it 'returns 201 status' do
      subject
      expect(last_response.status).to eq 201
    end

    it 'create an account' do
      subject
      expect(Account.count).to eq 1
    end
  end
end
