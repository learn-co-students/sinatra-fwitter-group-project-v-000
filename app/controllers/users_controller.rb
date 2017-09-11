class UsersController < ApplicationController

  # get '/signup' do
  #   if logged_in?
  #     redirect to '/tweets'
  #   else
  #     erb :"users/create"
  #   end
  # end

  get '/signup' do
    if !session[:user_id]
      erb :"users/create"
    else
      redirect to "/tweets"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end

  # post '/signup' do
  #   @user = User.new(params)
  #
  #   if params[:username].empty? || params[:email].empty? || params[:password].empty?
  #     redirect to '/signup'
  #   else
  #     @user.save
  #     session[:user_id] = @user.id
  #     redirect '/tweets'
  #   end
  # end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  # get '/login' do
  #   if logged_in?
  #     redirect to '/tweets'
  #   else
  #     erb :"users/login"
  #   end
  # end

  get '/login' do
    if !session[:user_id]
      erb :"users/login"
    else
      redirect to '/tweets'
    end
  end

  # post '/login' do
  #   @user = User.find_by(username: params[:username])
  #   if @user && @user.authenticate(params[:password])
  #     session[:user_id] == @user.id
  #     redirect to '/tweets'
  #   else
  #     redirect to '/login'
  #   end
  # end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  # get '/logout' do
  #   if logged_in?
  #     session.clear
  #     redirect to '/login'
  #   else
  #     redirect to '/'
  #   end
  # end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
