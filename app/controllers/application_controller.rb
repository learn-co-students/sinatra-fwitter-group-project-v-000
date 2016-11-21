require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  helpers do
    def current_user(session_hash)
      @user = User.find_by_id(session_hash[:user_id])
    end

    def is_logged_in?(session_hash)
      !!session_hash[:user_id]
    end
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    #binding.pry
    if is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    #binding.pry
    u ||= User.new(params)
    if !u.username.empty? && !u.email.empty? && u.password_digest
      #binding.pry
      u.save
      session[:id] = u.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    end
  end

  get '/tweets' do
    #binding.pry expected 1 argument got 0 params is empty! 
    @user = User.find_by(username: params(:username))
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do

    erb :'/tweets/create_tweet'
  end

  get '/logout' do
    if is_logged_in?(session)
      session.clear
    else
      redirect '/'
    end
  end

end
