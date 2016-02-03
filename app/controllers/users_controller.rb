class UsersController < ApplicationController

	get '/signup' do
		if !logged_in? 
			erb :'users/signup'
		else
			redirect '/tweets'
		end
	end

	post '/signup' do
		@user = User.create(params)
		if @user.save
			session[:id] = @user.id
			redirect '/tweets'
		else
			redirect '/signup'  #put in an error message here "There was an error, please try again"
		end
	end

	get '/login' do
		if !logged_in?
			erb :'users/login'
		else
			redirect '/tweets' #add error message
		end
	end

	post '/login' do
		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			session[:id] = @user.id
			redirect '/tweets'
		else
			redirect '/login' #add error message 'Sorry, wrong username or password'
		end
	end

	get '/logout' do
		session.clear
		redirect '/login'
	end

	get '/users/show' do
		erb :'users/show'
	end	

	get '/users/:slug' do
		@user = User.find_by_slug(params[:slug])
		session[:id] = @user.id
		if logged_in?						
			erb :'users/show'
		else 
			redirect '/login'
		end
	end
	
end


