Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
Sequel::Model.db = case Padrino.env
  when :development then Sequel.connect(
    adapter: :postgres,
    user: 'postgres',
    password: 'x1p2t3o4!',
    host: '127.0.0.1',
    port: 5432,
    database: 'steward_alfred_development',
    max_connections: 10,
    :loggers => [logger]
  )
  when :production  then Sequel.connect("postgres://localhost/padrino_test_production",  :loggers => [logger])
  when :test        then Sequel.connect("postgres://localhost/padrino_test_test",        :loggers => [logger])
end
