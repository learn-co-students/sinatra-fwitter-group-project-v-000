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

  get '/login' do
    if session[:user_id] == nil
     erb :'users/login'
    else
     redirect '/tweets'
    end
  end

  post '/login' do
    #if the user isn't logged in
    if session[:user_id] == nil
      #find user
      @user = User.find_by(username: params[:username], password: params[:password])
        #if user can't be found/authenticated
      if @user == nil
          #redirect to '/login'
        redirect '/login'
      else
        #otherwise set session[:user_id] to user.id and then redirect '/tweets
        session[:user_id] = @user.id
        redirect '/tweets'
      end
    #if the user is already logged in, redirect to '/tweets'
    else
      redirect '/tweets'
    end
  end


  get '/logout' do
    if session[:user_id] != nil
      session.clear
      redirect '/login'
    else
      redirect '/login'
    end
  end

  get '/users/:id' do
    erb :'users/show'
  end


end
