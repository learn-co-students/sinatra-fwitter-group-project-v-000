class UsersController < ApplicationController

  get '/signup' do
    erb :"/users/create_user"
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect "/signup"
    else
      @user = User.find_by(username: params[:username]) || @user = User.find_by(email: params[:email]) || @user = User.create(params)
      session[:user_id] = @user.id
    end
    redirect "/tweets"
  end

  get '/login' do

    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :"/users/show"
  end



end
