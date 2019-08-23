# loads dependencies

# constant (environment), if exists don't evaluate
ENV['SINATRA_ENV'] ||= "development"

# gem to load gems
require 'bundler/setup'
# require class method(require all gems in gemfile, environment)
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

# gem to require everything in folder
require_all 'app'
