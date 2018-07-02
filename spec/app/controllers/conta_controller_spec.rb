# frozen_string_literal: true

require 'spec_helper'

RSpec.describe '/conta' do
  describe '#post' do
    let(:conta) do
      {
        nome: 'conta corrente do banco',
        tipo: 'conta_corrente',
        total: 100
      }
    end
    subject do
      post '/conta', conta
    end

    it 'retorna 201' do
      subject
      expect(last_response.status).to eq 201
    end

    it 'cria uma conta' do
      subject
      expect(Conta.count).to eq 1
    end
  end
end
