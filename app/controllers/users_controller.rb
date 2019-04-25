class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'  
    else
      redirect '/tweets' 
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/create_user'  
    else
      redirect '/tweets' 
    end
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    @user.authenticate(params[:password])
    session[:user_id] = @user.id
    
    redirect '/tweets'
  end  

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else 
      redirect '/login'
    end
  end

end
    