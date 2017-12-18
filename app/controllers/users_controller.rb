class UsersController < ApplicationController
 
  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/users/create_user'
    end
  end
  
  post '/signup' do
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      
      if params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect '/signup'
      else
        @user.save
        session[:id] = @user.id
        redirect "/tweets"
      end
  end
  
  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"/users/login"
    end
  end
  
  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end
  
  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end
  
  get '/users' do
    if logged_in?
      @users = User.all
      erb :"/users/users"
    else
      redirect "/login"
    end
  end
  
end