require 'pry'
require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    "Welcome to Fwitter"
  end

  get '/signup' do
    # @user = User.create(params["user"])
    # binding.pry
    erb :'/index'
  end

  post '/signup' do
    redirect :'/tweets'
  end


end


#rspec ./spec/controllers/application_controller_spec.rb --fail-fast
