ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'


task :console do
  require 'irb'
  require_relative './config/environment'

  # require 'my_gem' # You know what to do.
  # ARGV.clear
  Pry.start
end
# Type `rake -T` on your command line to see the available rake tasks.