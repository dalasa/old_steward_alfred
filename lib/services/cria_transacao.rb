# frozen_string_literal: true

module Services
  # Service que efetua a criacao de uma conta
  class CriaTransacao
    def initialize(nome_conta:, descricao:, valor: ,tipo:, tags:, data_transacao:)
      @nome_conta = nome_conta
      @descricao = descricao
      @valor = valor
      @tipo = tipo
      @tags = tags
      @data_transacao = Date.parse(data_transacao)
    end

    def executa
      transacao = Transacao.create!(
        conta: conta,
        descricao: @descricao,
        valor: @valor,
        tipo: @tipo,
        tags: @tags,
        data_transacao: @data_transacao,
        data_efetivacao: @data_transacao + 1.day
      )
      atualiza_conta(transacao)
      transacao
    end

    private

    def conta
      @conta ||= Conta.find_by(nome: @nome_conta)
    end

    def atualiza_conta(transacao)
      conta.credita(transacao.valor) if transacao.entrada?
      conta.debita(transacao.valor) if transacao.saida?
      conta.save!
    end

  end
end
