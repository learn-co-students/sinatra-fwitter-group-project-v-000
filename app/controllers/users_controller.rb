class UsersController < ApplicationController

  get '/signup' do 
    if session[:user_id]
      redirect '/tweets'
    else
  	  erb :signup
    end
  end  

  post '/signup' do 
  	if params[:username] == "" || params[:password] == "" || params[:email] == ""
  		redirect '/signup' 
  	else
  		@user = User.create(username: params[:username], password: params[:password]) 
  		session[:user_id] = @user.id
  		redirect '/tweets' 
  	end
  end

  get '/login' do 
    if session[:user_id]
      redirect '/tweets' 
    else
  	  erb :login
    end
  end

  post '/login' do 
  	@user = User.find_by(username: params[:username])
  	if @user && @user.authenticate(params[:password])
  		session[:user_id] = @user.id
  		redirect '/tweets'
  	else
  		redirect '/login'
  	end
  end 

  get '/logout' do 
    if session[:user_id]
    	session.clear
    	redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug'	do 
  	@user = User.find_by(params[:slug])
  	erb :'users/show'
  end
end





