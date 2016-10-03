require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  erb :index
  end

  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

  post '/tweets' do
    erb :'tweets/tweets'
  end

  get '/signup' do
    erb :'users/create_user'

  end

  post '/signup' do
    
    erb :'tweets/tweets'
  end
end