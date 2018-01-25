class UsersController < ApplicationController

  get '/login' do
  	if logged_in?
  		redirect '/tweets'
  	else
  		erb :'users/login'
  	end
  end

  get '/signup' do
  	if logged_in?
  		redirect '/tweets'
  	else
  		erb :'users/create_user'
  	end
  end

  get '/users/:id' do
  	@user = User.find(params[:id])
  	erb :'users/show'
  end

  post '/signup' do
  	#binding.pry
  	if params[:user]
  		@user = User.new(params[:user])
  	else
  		@user = User.new(username: params[:username], email: params[:email], password: params[:password])
  	end
  	if @user.save
  		@user.save
  		session[:user_id] = @user.id
  		redirect to '/tweets'
  	else
  		redirect '/signup'
  	end
  end

  post '/login' do
  	@user = User.find_by_username(params[:username])
  	if @user && @user.authenticate(params[:password])
  		session[:user_id] = @user.id
  		redirect '/tweets'
  	else
  		redirect '/login'
  	end
  end



  get '/logout' do
  	session.clear
  	redirect '/login'
  end
end
