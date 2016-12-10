class UsersController < ApplicationController

	get '/signup' do
		unless logged_in? 
		erb :'users/signup'
		else
			redirect "/tweets"
		end
	end

	post '/signup' do
		unless params[:username] == "" || params[:email] == "" || params[:password] == ""
		@user = User.create(username: params[:username], email: params[:email], password: params[:password])
		session[:user_id] = @user.id
		redirect '/tweets'
		else
			redirect '/signup'
		end
	end

	get '/users/:slug' do
		@user = User.find_by_slug(params[:slug])
		erb :'users/show'
	end

	get '/login' do
		unless logged_in?
			erb :'users/login'
		else
			redirect '/tweets'
		end

	end

	post '/login' do 
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect '/tweets'
		else
			redirect '/signup'
		end
	end

	get '/logout' do
		if logged_in?
		session.clear
		redirect "/login"
		else
			redirect '/'
		end
	end

	

end