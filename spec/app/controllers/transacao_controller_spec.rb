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

    context 'quando a conta não existe' do
      it 'retorna 500' do
        subject
        expect(last_response.status).to eq 500
      end
    end

    context 'quando a conta existe' do
      before do
        Services::CriaConta.new(nome: 'conta do banco', tipo:'conta corrente', total: 100).executa
      end

      it 'retorna 201' do
        subject
        expect(last_response.status).to eq 201
      end

      it 'retorna uma transacao' do
        subject
        expect(Oj.load(last_response.body)).to have_key('descricao')
      end
    end
  end
end
