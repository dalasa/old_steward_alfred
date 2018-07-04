# frozen_string_literal: true

require 'spec_helper'

RSpec.describe '/transacao' do
  describe '#post' do
    let(:transacao) do
      {
        nome_conta: 'conta do banco',
        descricao: 'compra no mercado da esquina',
        valor: 100,
        tipo: 'saida',
        tags: ['mercado', 'alimentacao', 'essencial'],
        data_transacao: Date.new.to_s
      }
    end
    subject do
      post '/transacao', transacao
    end

    it 'retorna 201' do
      subject
      expect(last_response.status).to eq 201
    end

    it 'retorna uma transacao' do
      subject
      expect(Oj.load(last_response.body)).to have_key('descricao')
    end

    context 'quando a conta não existe' do
      it 'retorna 500' do
        subject
        expect(last_response.status).to eq 500
      end
    end
  end
end
