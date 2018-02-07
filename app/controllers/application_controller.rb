require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    "Welcome to Fwitter"
  end


end


#rspec ./spec/controllers/application_controller_spec.rb --fail-fast
