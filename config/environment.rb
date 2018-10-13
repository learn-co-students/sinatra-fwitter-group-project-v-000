ENV['SINATRA_ENV'] ||= "development"
ENV['SESSION_SECRET'] = "export SESSION_SECRET=84a22c140e3693c6037a536c26befa28d929d9d7d71a3667811aff614afde0efbe7c2fcc89caf10aee0e6d1d9df6ee8363f06ba3f31f7e0d2c79c7efbf9b9892 >> ~/.bashrc"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

require 'securerandom'



ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'app'
