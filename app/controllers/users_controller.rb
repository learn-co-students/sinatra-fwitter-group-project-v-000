class UsersController < ApplicationController
  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id

      redirect "/tweets/tweets"
    else
      redirect '/signup'
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      sessions[:user_id] = @user.id
      redirect "/tweets/tweets"
    end
    redirect '/login'
  end
end
