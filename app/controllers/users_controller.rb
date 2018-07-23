class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end

  get '/signup' do
    if !is_logged_in?
      erb :signup
    else
      redirect :'/tweets'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect :"/signup"
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect :"/tweets"
    end
  end

  get '/login' do
    if !is_logged_in?
      erb :login
    else
      redirect :'/tweets'
    end
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect :"/tweets"
    else
      redirect :"/signup"
    end
  end

  get "/logout" do
    session.clear
    redirect :login
  end
end
