class UsersController < ApplicationController

configure do
  enable :sessions unless test?
  set :session_secret, "fwitter"
end

get '/signup' do
    if session[:user_id] == nil
      erb :'users/signup'
    else
      @user = User.find_by(session[:user_id])
      @tweets = Tweet.all
      redirect :'/tweets'
    end
end

get "/login" do
  if session[:user_id] == nil
    erb :'users/login'
  else
    redirect :'/tweets'
  end
end

get "/users/:slug" do
   @user = User.find_by_slug(params[:slug])
   if @user
  erb :'/users/show'
else
  redirect :"/login"
end
end

post '/signup' do
  if params[:username].empty? || params[:password].empty? || params[:email].empty?
    redirect :'/signup'
  else
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect :'/tweets'
  end
end

post '/login' do
  @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect :'/tweets'
    else
      redirect to :"/login"
    end
  end

  get "/logout" do
    session.clear
    redirect :"/login"
  end

end
