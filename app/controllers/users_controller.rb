class UsersController < ApplicationController
 
  get '/signup' do 
    if !logged_in?
      erb :'/users/signup'
    else 
      redirect to '/tweets'
    end
  end 
  
  
  post '/signup' do 
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      flash[:message] = "Missing Username, Email or Password."
      redirect to '/signup'
    else 
      user = User.create(params)
      flash[:message] = "User created successfully. Logging you in.."
      session[:user_id] = user.id
      redirect to '/tweets'
    end 
  end 
  
  
  get '/login' do 
    if !logged_in?
      erb :'/users/login'
    else 
      redirect to '/tweets'
    end 
  end 
  
  
  post '/login' do 
    user = User.find_by(:username => params[:username])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id 
      flash[:message] = "Logged in successfully."
      redirect to '/tweets'
    else 
      flash[:message] = "Username or Password is incorrect."
      redirect to '/login'
    end 
  end   
  
  
  get '/logout' do 
    if !logged_in?
      redirect to '/'
    else 
      flash[:message] = "Logged out successfully."
      session.clear
      redirect to '/login'
    end 
  end 
  
  
  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end 
   

end
