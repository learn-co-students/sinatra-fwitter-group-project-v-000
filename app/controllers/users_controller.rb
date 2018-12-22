class UsersController < ApplicationController

  get '/signup' do
    erb :"/users/create_user"
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect "/signup"
    else
      @user = User.find_by(username: params[:username]) || @user = User.find_by(email: params[:email]) || @user = User.create(params)
      session[:id] = @user.id
    end
    redirect "/tweets"
  end

  get '/login' do

    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      redirect "/tweets"
    end
  end

  get '/:slug' do
    @user = User.find_by(session[:id])
  end





end
