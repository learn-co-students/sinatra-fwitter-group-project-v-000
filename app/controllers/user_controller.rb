class UserController < ApplicationController 

  get '/signup' do
  	if logged_in?
  		redirect to '/tweets'
  	else	
      erb :signup
    end  
  end
  
  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end
  
  get '/login' do
  	if logged_in?
  		redirect to '/tweets'
  	else	
  	  erb :'users/login'
  	end  
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
    	session[:user_id] = @user.id
    	redirect to '/tweets'
    else 
      redirect to '/login'
    end	
  end 
    
  get '/logout' do
  	session.clear
  	redirect to '/login'
  end

  get '/failer' do
    redirect to '/login'
  end

  get '/users/:slug' do
  	@user = User.find_by_slug(params[:slug])
  	erb :'users/show'
  end
end