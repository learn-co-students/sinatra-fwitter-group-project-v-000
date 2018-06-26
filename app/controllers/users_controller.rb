class UsersController < ApplicationController

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :'/users/'
  end

  get '/signup' do
    if session[:user_id]
      redirect :'/tweets'
    end
    erb :'/users/signup'
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to :'/signup'
    end
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect to :'/tweets'
  end

  get '/login' do
    if session[:user_id]
      redirect :'/tweets'
    end
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect :'/login'
  end

end
