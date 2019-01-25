class UsersController < ApplicationController

  get '/users' do
    @users = User.all
    erb :'users/index'
  end

  get '/signup' do
    if session[:user_id] == nil
       erb :'users/new'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if !params.has_value?("")
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect "/signup"
    end
  end

  get '/users/:id' do
    erb :'users/show'
  end
end
