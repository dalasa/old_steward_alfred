# frozen_string_literal: true

require 'spec_helper'

RSpec.describe '/accounts' do
  describe '#post' do
    let(:account) do
      {
        name: 'my bank checking account',
        kind: 'checking',
        total: 100
      }
    end
    subject do
      post '/accounts', account
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
