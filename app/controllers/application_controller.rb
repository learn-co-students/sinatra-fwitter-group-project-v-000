require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if User.is_logged_in?(session)
      redirect '/tweets/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      User.create(username: params[:username], password: params[:password])
      redirect '/tweets/tweets'
    end
  end

  get '/login' do
    erb :'users/login'
  end
end
