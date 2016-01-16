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
    #checks if logged in
    if session[:user_id]
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if !params["username"].empty? && !params["email"].empty? && !params["password"].empty?
      @user = User.new(username: params["username"], email: params["email"], password: params["password"])
      @user.save #if password isn't provided because of has_secure_password, it will fail
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password]) #checks if a user was found and authenticates to password digest
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do

  end

  post '/logout' do

  end

  get '/tweets' do
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/users/:user_slug' do
    #@user =
    #erb
  end

  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params[:content])
    #@tweet.user_id = ??
  end

  get '/tweets/:tweet_id' do
    @tweet = Tweet.find_by_id(params[:tweet_id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:tweet_id/edit' do
    erb :'tweets/edit_tweet'
  end

  post '/tweets/:tweet_id' do

  end

  post '/tweets/:tweet_id/delete' do

  end

end