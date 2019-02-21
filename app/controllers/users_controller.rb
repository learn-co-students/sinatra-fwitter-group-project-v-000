class UsersController < ApplicationController
  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    if !logged_in?
      redirect '/signup' if params[:username].empty? || params[:email].empty? || params[:password].empty?

      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      login(@user.username, @user.email, @user.password)
      redirect "/tweets/tweets"
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    login(params[:username], params[:email], params[:password])
    redirect "/tweets/tweets"
  end

  get '/logout' do
    logout
  end
end
