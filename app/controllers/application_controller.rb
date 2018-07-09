require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?(session)
      redirect '/tweets'
    end
    erb :'users/create_user'
  end

  get '/tweets' do
    if !logged_in?(session)
      redirect '/login'
    end
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    end
    @user = User.create(params)
    session[:id] = @user.id
    redirect '/tweets'
  end

  get '/login' do
    if logged_in?(session)
      redirect '/tweets'
    end
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/tweets/new' do
    if !logged_in?(session)
      redirect '/login'
    end

    erb :'tweets/create_tweet'
  end

  post '/tweets' do
      tweet = Tweet.create(params)
  end




  def current_user(session)
    User.find_by_id(session[:id])
  end

  def logged_in?(session)
    !!session[:id]
  end

end
