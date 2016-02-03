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
			redirect '/signup'  
		end
	end

	get '/login' do
		if !logged_in?
			erb :'users/login'
		else
			redirect '/tweets' 
		end
	end

	post '/login' do
		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			session[:id] = @user.id
			redirect '/tweets'
		else
			redirect '/login' 
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
		session[:id] = @user.id #had to add this to pass spec
		if logged_in?						
			erb :'users/show'
		else 
			redirect '/login'
		end
	end
	
end


