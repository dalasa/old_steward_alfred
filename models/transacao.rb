class Transacao < ActiveRecord::Base
  self.table_name = 'transacoes'
  belongs_to :conta
  validates :conta, presence: true
  enum tipo: { saida: 0, entrada: 1 }
end
