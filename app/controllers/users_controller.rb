class UsersController < ApplicationController
  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = @user.id
  end
end
