# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'StewardAlfred::App::AuthorizationHelper' do
  let(:helpers) { Class.new }
  before { helpers.extend StewardAlfred::App::AuthorizationHelper }

  context '#authorize!' do
    before do
      ENV['JWT_ISSUER'] = jwt_issuer
      ENV['JWT_SECRET'] = jwt_secret
    end

    subject do
      header 'Authorization', authorization
      get '/authtest'
    end

    let(:jwt_secret) { 'testsecret' }
    let(:jwt_issuer) { 'StewardAlfredTest' }

    let(:payload) { { data: 'test', iss: jwt_issuer } }
    let(:token) { JWT.encode payload, jwt_secret, 'HS256' }
    let(:authorization) { "Bearer #{token}" }

    context 'when everything is ok' do
      it 'returns a 200 code' do
        subject
        expect(last_response.status).to eq 200
      end
    end

    context 'when invalid token' do
      context 'by wrong issuer' do
        let(:payload) { { data: 'test', iss: 'wrong issuer' } }
        it 'returns a 403 code' do
          subject
          expect(last_response.status).to eq 403
        end
      end

      context 'by invalid encoded token' do
        let(:token) { JWT.encode payload, 'falseysecret', 'HS256' }
        it 'returns a 403 code' do
          subject
          expect(last_response.status).to eq 403
        end
      end
    end
  end
end
