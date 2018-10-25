class UsersController < ApplicationController

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :signup
  end

  get '/users/login' do
    erb :'/users/login'
  end

  post '/signup' do
    @user = User.create(params)
    session[:id] = @user.id

    redirect to "/users/login"
  end

end
