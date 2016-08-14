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
    user.email = params['email']
    user.save
    session[:user] = user.username
    redirect '/tweets'
  end

  get '/login' do
    redirect '/tweets' if logged_in?
    erb :'users/login'
  end

  post '/sessions' do
    puts params
    redirect '/login' if params['username'] == "" || params['password'] == ""
    username = params['username']
    if user = User.find_by(:username => username)
      session[:user] = user.username
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    logout!
    redirect '/'
  end
end
