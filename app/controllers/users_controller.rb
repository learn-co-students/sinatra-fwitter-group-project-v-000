class UsersController < ApplicationController

  configure do
  enable :sessions
  set :session_secret, "secret"
end

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'

    else
      redirect '/tweets'
  end
  end

  post '/signup' do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if @user.save && @user.username !="" && @user.password !="" && @user.email !=""
      session[:user_id]=@user.id
    redirect '/tweets'
  else

    redirect '/signup'
  end
  redirect '/tweets'
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
    erb :'/users/login'
  end
  end

  post '/login' do
    @user = User.find_by(:username=> params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
    else
      redirect 'login'

    end
    redirect '/tweets'
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  get '/users/:slug' do

    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end






end
