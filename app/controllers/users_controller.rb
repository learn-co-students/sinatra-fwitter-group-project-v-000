class UsersController < ApplicationController

  get '/' do
    erb :'/users/home'
  end

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect '/tweets/index'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    user = User.new(params)

    if user.save
      session[:user_id] = user.id
      redirect '/tweets/index'
    else
      redirect '/users/signup'
    end
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect '/tweets/index'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/users/error"
    end
  end

  get '/tweets' do
    @user = User.find_by_id(session[:user_id])

    if @user
      erb :'/tweets/index'
    else
      redirect '/error'
    end
  end

  get '/error' do
    erb :'/users/error'
  end

  get '/logout' do
    session.clear
    redirect :'/users/home'
  end
end
