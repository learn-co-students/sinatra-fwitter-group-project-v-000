class UsersController < ApplicationController

	get '/login' do 
		logged_in? ? (redirect '/tweets') : (erb :'/users/login')
	end


	post '/login' do
		user = User.find_by(username: params[:username])
			if user && user.authenticate(params[:password])
				session[:user_id] = user.id
				redirect '/tweets'
			elsif !user
				redirect '/signup'
				flash[:message] = "Invalid user.  Please sign up."
			end
	end


	get '/logout' do 
		session.clear
		success
		redirect '/login'
	end

	
	get '/signup' do 
		if logged_in?
			success
			redirect '/tweets'
		else
			erb :'/users/create_user'
		end
	end


	post '/signup' do 
		@user = User.create(params) if filled_out(params)
			if @user
				@user.id = User.all.last.id
				session[:user_id] = @user.id
				success
				redirect '/tweets'
			elsif !@user && !logged_in?
				failure
				redirect '/signup'
			end
	end


	get '/users/:slug' do 
		@user = User.find_by_slug(:slug)
		erb :'/users/show'
	end


end
