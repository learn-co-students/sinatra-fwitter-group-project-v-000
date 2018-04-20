class UsersController < ApplicationController

  get '/' do
    erb :'/users/home'
  end

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    if params[:username] == ""|| params[:email] == ""|| params[:password] == ""
      erb :'/users/signup'
    else
      @user = User.create(username:params["username"], email: params["email"], password: params["password"])
      @user.save
      redirect '/tweets'
    end
  end
end
