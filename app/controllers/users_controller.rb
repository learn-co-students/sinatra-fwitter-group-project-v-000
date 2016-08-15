class UsersController < ApplicationController
  enable :sessions
  set :session_secret, 'fwitter'
  set :public_folder, 'public'
  set :views, 'app/views'

  get '/signup' do
    redirect '/tweets' if logged_in?
    erb :'users/create'
  end

  post '/signup' do
    redirect '/signup' if params['username'] == "" || params['email'] == "" || params['password'] == ""
    user = User.create
    user.username = params['username']
    user.password = params['password']
    user.email = params['email']
    user.save
    session[:user] = user.username
    redirect '/tweets'
  end

  get '/login' do
    redirect '/tweets' if logged_in?
    erb :'users/login'
  end

  post '/login' do
    redirect '/login' if params['username'] == "" || params['password'] == ""
    login(params['username'], params['password'])
    redirect '/tweets'
  end

  get '/logout' do
    logout!
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = Tweet.collect { |tweet| tweet.user_id == @user.id }
    erb :'/tweets/tweets'
  end
end
