class UsersController < ApplicationController

  get '/signup' do
    erb
  end

  get '/login' do
    erb :"users/login"
  end

  get '/logout' do
    logout!
  end

  post '/login' do
    login(params[:username], params[:password])
    end
  end

  post '/signup' do
    @user = User.new
    @user.username = params[:username]
    @user.email = params[:email]
    @user.password = params[:password]
    if @user.save
      login(params[:username], params[:password])
    else
      erb :"users/login"
    end
  end

end
