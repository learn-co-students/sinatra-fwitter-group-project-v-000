class UserController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect to '/login'
    end

  end

  post '/signup' do
    user = User.create(username: params[:username], email: params[:email], password: params[:password])

    if user
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
  end

end
