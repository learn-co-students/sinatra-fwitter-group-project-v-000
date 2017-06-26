ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

task :console do
    pry.start
end

def reload!
    load_all 'app'
end


# Type `rake -T` on your command line to see the available rake tasks.