class Transacao < ActiveRecord::Base
  self.table_name = 'transacoes'
  belongs_to :conta
  validates :conta, presence: true
end
