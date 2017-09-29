require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
  	enable :sessions
  	set :session_secret, "Tony-b4G-a-dOoOoonUt$$$$"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  	erb :index
  end

  get '/signup' do
  	erb :'/users/create_user'
  end

  get '/login' do
  	erb :'/users/login'
  end

  get '/tweets' do
    erb :'/tweets/tweets'
  end

end