require 'pry'
class UsersController < ApplicationController

  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect '/tweets'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      session[:login_error] = "Must include username, email and password"
      redirect '/signup'
    else
      @user = User.create(params)
      session[:login_error] = nil
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  post '/login' do
    login(params[:username], params[:password])
    redirect '/tweets'
  end

  get '/logout' do
    if logged_in?
      logout!
      redirect '/login'
    else
      redirect to '/'
    end
  end

end
