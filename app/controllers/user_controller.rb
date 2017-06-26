class UserController < ApplicationController
  
  get '/' do
    @user = current_user
  	erb :index
  end 

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else 
      erb :'users/create_user'
    end 
  end 

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    end 
  end 

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else 
      erb :'users/login'
    end 
  end 

  post '/login' do
    @user = User.find_by(username: params[:username]).authenticate(params[:password])
    if @user == false 
      redirect '/login'
    else
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end 

  get '/logout' do
    session.clear
    redirect '/login'
  end 

end 