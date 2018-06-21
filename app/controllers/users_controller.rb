class UsersController < ApplicationController

  get '/signup' do
    redirect to '/tweets' if logged_in?
    erb :'users/new'
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    redirect to '/tweets' if logged_in?
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
    end
    redirect to '/tweets'
    # not recognizing redirect
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
