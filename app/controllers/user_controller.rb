class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/create_user"
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/"
    end
  end
end
