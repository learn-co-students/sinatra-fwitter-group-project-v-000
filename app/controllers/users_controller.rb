class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/create_user'
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/signup' do
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])
    if @user.save
      redirect :'/tweets'
    else
      redirect :'/user/signup'
    end
  end

  post '/login' do
    @user = User.find_by(email: params["email"], password: params["password"])
    if @user != nil
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    erb :'/tweets/tweets'
  end

end
