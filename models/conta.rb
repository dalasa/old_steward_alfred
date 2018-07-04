class Conta < ActiveRecord::Base
  self.table_name = 'contas'
  has_many :transacao
end
