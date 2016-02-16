ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
require 'require_all'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

