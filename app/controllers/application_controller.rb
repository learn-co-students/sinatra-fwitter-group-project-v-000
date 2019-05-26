require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :'/users/login'
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
  end

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  post '/tweets' do
  end

end
