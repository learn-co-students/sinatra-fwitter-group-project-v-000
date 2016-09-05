require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "the_trillest"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !session[:user_id]
      erb :'/users/signup'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user != nil
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  get '/tweets' do
    if session[:user_id]
      @user_tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

end