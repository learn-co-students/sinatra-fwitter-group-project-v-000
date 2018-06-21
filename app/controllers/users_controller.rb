class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/users/login'
    end
  end

  post '/signup' do
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])
    if @user.save
      session[:id] = @user.id
      redirect :'/tweets'
    else
      redirect :'/signup'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    @user.tweets
    erb :'/users/show'
  end

end
