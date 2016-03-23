class UserController < ApplicationController
  get '/' do
    erb :index
  end

  get '/signup' do
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

  get '/signup' do
    if User.is_logged_in?(session)
      redirect '/tweets/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      User.create(username: params[:username], password: params[:password])
      redirect '/tweets/tweets'
    end
  end
end
