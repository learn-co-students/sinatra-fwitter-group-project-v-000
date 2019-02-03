class UsersController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    @user = User.create(params)
    # Log user in
    # Add user_id to sessions hash
    redirect ""
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find(params[:id])
    # Log user in
    # Add user_id to sessions hash
    redirect ""
  end

  get '/logout' do
    @user = User.find(params[:id])
    # Clear session hash
    redirect "/login"
  end

end
