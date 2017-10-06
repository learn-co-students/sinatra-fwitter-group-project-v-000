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
    erb :'tweets/create_tweet'
  end

  post '/signup' do
    @user = User.new(params)
  end

end
