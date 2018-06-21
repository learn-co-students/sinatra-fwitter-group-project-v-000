class UsersController < ApplicationController

  get '/signup' do

    erb :"users/create_user"
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    @user.save
    if @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    erb :"users/login"
  end


end
