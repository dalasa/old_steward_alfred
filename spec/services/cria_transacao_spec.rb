# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Services::CriaTransacao do
  describe '#executa' do
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
      described_class.new(transacao).executa
    end

    context 'quando a conta não existe,' do
      it 'uma excecao ActiveRecord::RecordInvalid é lançada' do
        expect{subject}.to raise_error(ActiveRecord::RecordInvalid)
      end
      it 'lanca excecao para o campo conta que esta nulo' do
        expect{subject}.to raise_error('Validation failed: Conta can\'t be blank')
      end
    end

    context 'quando a conta existe' do
      before do
        Services::CriaConta.new(nome: 'conta do banco', tipo:'conta corrente', total: 100).executa
      end

      it 'cria a transacao com sucesso' do
        subject
        expect(Transacao.count).to eq 1
      end

      it 'retorna a transacao criada' do
        expect(subject).to be_a(Transacao)
      end
    end
  end
end