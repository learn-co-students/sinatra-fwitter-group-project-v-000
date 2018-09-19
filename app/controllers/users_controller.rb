class UsersController < ApplicationController

  get '/signup' do
    erb :'users/new'
  end

  post '/users' do
    @user = User.new
    @user.user_name = params[:user_name]
    @user.email = params[:email]
    @user.password = params[:password]
    if @user.save
      erb :'/tweets/index'
    else
      erb :'users/new'
    end
  end

end
