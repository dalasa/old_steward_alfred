# frozen_string_literal: true

require 'database_cleaner'

RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + '/../config/boot')
Dir[File.expand_path(File.dirname(__FILE__) + '/../app/helpers/**/*.rb')].each(&method(:require))

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  conf.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  conf.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

def setup_api_authorization
  ENV['JWT_ISSUER'] = jwt_issuer = 'testsecret'
  ENV['JWT_SECRET'] = jwt_secret = 'StewardAlfredTest'
  token = JWT.encode({ iss: jwt_issuer }, jwt_secret, 'HS256')
  header 'Authorization', "Bearer #{token}"
end

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app StewardAlfred::App
#   app StewardAlfred::App.tap { |a| }
#   app(StewardAlfred::App) do
#     set :foo, :bar
#   end
#
def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end
