class UserController < ApplicationController

  get '/' do
    erb :index
  end

  get '/login' do
    if User.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/signup' do
    if User.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      User.create(username: params[:username], password: params[:password])
      redirect '/tweets'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/users/:id' do
    @user = User.find_by(params[:id])
    erb :'/tweets/show_tweet'
  end
end
