class UserController < ApplicationController
  get '/' do
    erb :index
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    erb :'/users/login'
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
      User.create(username: params[:username], email: params[:email], password: params[:password])
      redirect '/tweets'
    end
  end

  get '/users/:id' do
    @user = User.find_by(params[:id])
    erb :'/tweets/show_tweet'
  end
end
