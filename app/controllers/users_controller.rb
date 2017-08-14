class UsersController < ApplicationController

	get '/signup' do
		if logged_in?(session)
			redirect '/tweets'
		else
			erb :'users/create_user'
		end
	end

	post '/signup' do
		#does not let user signup without valid info
		if params[:username] == "" || params[:email] == "" || params[:password] == ""
			redirect '/signup'
		else
			user = User.new(username: params[:username], email: params[:email], password: params[:password])
			user.save
			session[:user_id] = user.id
			redirect '/tweets'
		end
	end

	get '/login' do
		if logged_in?(session)
			redirect '/tweets'
		else
		erb :'/users/login'
		end
	end

	post '/login' do
		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect '/tweets'
		else
			redirect '/signup'
		end
	end

	get '/logout' do
		if logged_in?(session)
			session.clear
			redirect '/login'
		else
			redirect '/login'
		end
	end

	get '/users/:slug' do
		@user = User.find_by_slug(params[:slug])
		@tweets = @user.tweets
		erb :'/users/show'
	end

end