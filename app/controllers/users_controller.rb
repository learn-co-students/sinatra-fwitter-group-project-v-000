class UsersController < ApplicationController

	get '/login' do
		if !logged_in?
  			erb :'/users/login'
  		else
  			redirect to '/tweets'
  		end

  	end

	post '/login' do
		user = User.find_by(:username => params[:username])
		
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
  			redirect to '/tweets'
		end
	end

 	get '/logout' do
 		if logged_in?
			session.clear
			redirect '/login'
		else
			redirect to '/'
		end
	end

	get '/users/:slug' do
		@user = User.find_by_slug(params[:slug])
		erb :'/users/show'
	end

	get '/index' do
		if logged_in?
			redirect '/tweets/tweets'
		end
	end


end
