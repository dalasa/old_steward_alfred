# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Services::CriaTransacao do
  describe '#executa' do
    let(:nome_conta) { 'conta do banco' }
    let(:tipo_transacao) { :saida }
    let(:transacao) do
      {
        nome_conta: nome_conta,
        descricao: 'compra no mercado da esquina',
        valor: 50,
        tipo: tipo_transacao,
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
      let(:total_inicial_conta) { 100 }

      before do
        Services::CriaConta.new(nome: 'conta do banco', tipo:'conta corrente', total: total_inicial_conta).executa
      end

      it 'cria a transacao com sucesso' do
        subject
        expect(Transacao.count).to eq 1
      end

      it 'retorna a transacao criada' do
        expect(subject).to be_a(Transacao)
      end

      context 'a transacao é de saida' do
        let(:tipo_transacao) { 'saida' }
        it 'subtrai o valor da transacao ao total da conta' do
          transacao = subject
          expect(Conta.find_by(nome: nome_conta).total).to eq (total_inicial_conta - transacao.valor)
        end
      end

      context 'a transacao é de entrada' do
        let(:tipo_transacao) { :entrada }
        it 'soma o valor da transacao ao total da conta' do
          transacao = subject
          expect(Conta.find_by(nome: nome_conta).total).to eq (total_inicial_conta+transacao.valor)
        end
      end

    end
  end
end
