class UsersController < ApplicationController
  
  get '/users' do
    @users = User.all 
    erb :'users/all_users'
  end 
  
  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end 
  
  get '/signup' do 
    if !logged_in?
      erb :'users/create_user'
    else 
      redirect to "/tweets"
    end 
  end 
  
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
  
  get '/login' do 
    if !logged_in?
      erb :'users/login'
    else 
      redirect to '/tweets'
    end 
  end 
  
  post '/login' do 
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id 
      redirect to '/tweets'
    else 
      redirect to '/signup'
    end 
  end 
  
  get '/logout' do 
    session.clear 
    redirect to '/login'
  end 

end
