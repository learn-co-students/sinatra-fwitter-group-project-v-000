class UsersController < ApplicationController

  get '/users' do
    erb :'layout'
  end

  get '/signup' do
    if session[:user_id] == nil
       erb :'users/create_user'
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

  get '/users/login' do
    erb :'users/login'
  end

  post '/users/login' do
    
  end

  get '/users/:id' do
    erb :'users/show'
  end


end
