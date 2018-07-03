class CreateContas < ActiveRecord::Migration[5.1]
  def self.up
    create_table :contas do |t|
      t.string :nome
      t.string :tipo
      t.float :total
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :contas
  end
end
