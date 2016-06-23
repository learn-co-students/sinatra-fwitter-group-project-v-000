require 'rack-flash'

class UsersController < ApplicationController

	get '/signup' do
		if !session[:user_id]
			erb :'/users/create_user'
		else
			redirect to '/tweets'
		end
	end

	post '/signup' do
		user = params[:username].size
		email = params[:email].size
		password = params[:password].size

		if user < 1 || email < 1 || password < 1
			flash[:message] = "All fields must be filled out."
			redirect to "/signup"
		else
			@user = User.create(username: params[:username], email: params[:email], password: params[:password])
			@user.save
			session[:user_id] = @user.id

			flash[:message] = "Account successfully created!"

			redirect to '/tweets'
		end
	end

	get '/login' do
		if !session[:user_id]
			erb :'users/login'
		else
			redirect to '/tweets'
		end
	end

	post '/login' do
		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			@user.save
			session[:user_id] = @user.id

			flash[:message] = "You have sucessfully logged in!"

			redirect to '/tweets'
		else
			flash[:message] = "Username or password is invalid. Please try again."
			redirect to '/login'
		end
	end

	get '/logout' do
		session.clear
		redirect to '/login'
	end

	get '/users/:slug' do
		@user = User.find_by_slug(params[:slug])
		erb :'/users/show'
	end

end