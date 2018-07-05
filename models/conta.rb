class Conta < ActiveRecord::Base
  self.table_name = 'contas'
  has_many :transacao
  # attr_reader :nome, :tipo, :total

  def credita(valor)
    self.total += valor
  end

  def debita(valor)
    self.total -= valor
  end
end
