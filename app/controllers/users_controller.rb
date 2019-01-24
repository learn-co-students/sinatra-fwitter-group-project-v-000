class UsersController < ApplicationController

  get '/users' do
    @users = User.all
    erb :'users/index'
  end

  get '/signup' do
    erb :'users/new'
  end

  post '/signup' do
    @user = User.create(username: params[:user][:username], email: params[:user][:email], password: params[:user][:password])
    @user.save
    session[:id] = @user.id
    redirect '/tweets'
  end
  
end
