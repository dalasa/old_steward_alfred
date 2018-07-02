# frozen_string_literal: true

module Services
  # Service que efetua a criacao de uma conta
  class CriaConta
    def initialize(nome:, tipo:, total:)
      @nome = nome
      @tipo = tipo
      @total = total
    end

    def executa
      conta = Conta.new(nome: @nome, tipo: @tipo, total: @total)
      conta.save
    end
  end
end
