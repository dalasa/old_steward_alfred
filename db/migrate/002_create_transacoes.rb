class CreateTransacoes < ActiveRecord::Migration[5.1]
  def self.up
    create_table :transacoes do |t|
      t.belongs_to :conta, index: true
      t.string :descricao, null: false
      t.float :valor, null: false
      t.string :tipo, null: false
      t.string :tags, array: true, default: []
      t.date :data_transacao, null: false
      t.date :data_efetivacao, null: false
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :transacoes
  end
end
