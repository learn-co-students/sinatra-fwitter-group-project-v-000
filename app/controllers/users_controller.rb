class UsersController < ApplicationController
  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    @user = User.create(params)
    session[:id] = @user.id
    redirect to '/tweets'
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by_id(params["id"])
    session[:id] = @user.id
    redirect to
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end
end
