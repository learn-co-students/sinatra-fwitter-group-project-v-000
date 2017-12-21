ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'



# Type `rake -T` on your command line to see the available rake tasks.

 namespace :db do
   desc "simple debuging environment"
   task :console do
     load './config/environment.rb'
      Pry.start
   end
 end
