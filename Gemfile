# frozen_string_literal: true

source 'https://rubygems.org'

# Padrino supports Ruby version 2.2.2 and later
# ruby '2.5.1'

# Distribute your app as a gem
# gemspec

# Server requirements
# gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Optional JSON codec (faster performance)
# gem 'oj'

# Project requirements
gem 'pry-byebug'
gem 'rake'
gem 'rubocop'
group :test do
  gem 'database_cleaner'
end

# Component requirements
gem 'erubi', '~> 1.6'
gem 'pg'
gem 'sequel'

# Test requirements
gem 'rack-test', require: 'rack/test', group: 'test'
gem 'rspec', group: 'test'

# Padrino Stable Gem
gem 'padrino', '0.14.3'

# Or Padrino Edge
# gem 'padrino', :github => 'padrino/padrino-framework'

# Or Individual Gems
# %w(core support gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.14.3'
# end
