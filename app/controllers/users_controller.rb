require 'pry'
class UsersController < ApplicationController
  enable :sessions
  set :session_secret, 'fwitter'
  set :public_folder, 'public'
  set :views, 'app/views'

# Displayse the "Sign Up" form and creates a new user
  get '/signup' do
    redirect '/tweets' if logged_in?
    erb :'users/create'
  end

  post '/signup' do

    user = User.create(params)
    session[:id] = user.id

    if user.save
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

# Displayse the "Log In" form and logs in user
  get '/login' do
    redirect '/tweets' if logged_in?
    erb :'users/login'
  end

  post '/login' do
    redirect '/login' if params[:username] == "" || params[:password] == ""
    login(params[:username], params[:password])
    redirect '/tweets'
  end

# Logs out user
  get '/logout' do
    logout!
    redirect '/login'
  end

# Displays individual user's tweets
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug].to_s)
    @tweets = []
    Tweet.all.each do |tweet|
      @tweets << tweet if tweet.user_id == @user.id
    end
    erb :'/tweets/tweets'
  end
end
