class UsersController < ApplicationController


	get '/signup' do 

		if !logged_in?
			erb :'users/create_user'
		else

			redirect to "/tweets"
		end

	end

	get '/login' do
		if logged_in?
			redirect to "/tweets"
		else
			erb :'users/login'
		end
	end

	post '/signup' do
	


		if params[:username] == "" || params[:password] == "" || params[:email] == "" 
			redirect to '/signup'
		else
			
			@user = User.create(username: params[:username], email: params[:email], password: params[:password])
			session[:user_id] = @user
			redirect "/tweets"
		end
		

	end

	post '/login' do

		@user = User.find_by(username: params[:username])
	

		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user

			redirect to "/tweets"
		else
			redirect to "/signup"

		end


	end

	get '/logout' do
		if logged_in?
			session.clear
			redirect to "/login"
		end

			redirect to "/"
	end

	get '/users/:slug' do

		@user = User.find_by_slug(params[:slug])
		erb :'users/show'

	end



end