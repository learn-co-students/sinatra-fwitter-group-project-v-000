class UserController < ApplicationController
  
  get '/signup' do
    redirect '/tweets' if logged_in?
      
    erb :'users/create_user'
  end
  
  get '/login' do
    redirect '/tweets' if logged_in?
      
    erb :'users/login'
  end 
  
  get '/logout' do 
    session.clear 
    redirect '/login'
  end 
  
  get '/users/profile' do 
    check_logged_in
    
    redirect "/users/#{current_user.slug}"
  end 
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    redirect '/login' if @user != current_user
    
    erb :'/users/show'
  end 
  
  post '/login' do 
    @user = User.find_by(username: params[:username])
    
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id 
      redirect '/tweets'
    else
      erb :'users/login'
    end 
  end 
  
  post '/signup' do
    redirect '/signup' if !valid_signup?
    
    user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect '/tweets'
  end
  
  helpers do 
    def valid_signup?
      params.values.all?{ |v| !v.empty? }
    end
  end 
  
end 