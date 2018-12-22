class UsersController < ApplicationController

  get '/signup' do

    if User.find_by_id(session[:user_id]) != nil
      redirect "/tweets"
    else
      erb :'/users/signup'
    end

  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  
  end

  get '/login' do
    if User.find_by_id(session[:user_id]) != nil
      redirect "/tweets/index"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user != nil && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  post '/signup' do

    if !params[:username].empty? && !params[:password].empty? && !params[:email].empty?
      user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/logout' do
    if User.find_by_id(session[:user_id]) == nil
      redirect '/login'
    else
      session.clear
      if session.empty?
        redirect '/login'
      else
        redirect '/tweets'
      end
    end
  end
end
