require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/users/create_user' do
    erb :'users/create_user'
  end

  post '/users' do
    user = User.new(params[:user])
    if user.save
      redirect '/users/login'
    else
      redirect '/users/crete_user'
    end
  end

  get '/users/login' do
    erb :'users/login'
  end

  post '/users/login' do
    user = User.find_by_username(params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect 'users/show'
    else
      redirect 'users/login'
    end
  end

  get 'user/show' do
    @user = User.find_by_id(session[:user_id])
    if @user
      erb :'user/show'
    else
      redirect 'users/login'
    end
  end

end