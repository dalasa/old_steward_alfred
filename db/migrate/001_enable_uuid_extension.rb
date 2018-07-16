class EnableUuidExtension < ActiveRecord::Migration[5.1]
  def self.up
    enable_extension 'uuid-ossp'
  end

  def self.down
  end
end
