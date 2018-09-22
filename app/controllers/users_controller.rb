class UsersController < ApplicationController

	get '/signup' do
		#binding.pry
		if logged_in?
			redirect '/tweets'
		else
			erb :'/users/create_user'
		end
	end

	post '/signup' do
		#binding.pry
		user = User.new(username: params["username"], email: params["email"], password: params["password"])

		if params[:username].empty? || params[:password].empty? || params[:email].empty?
			redirect '/signup'
		else
			user.save
			session[:id] = user[:id]
			redirect '/tweets'
		end
	end

	get '/login' do
		if logged_in?
			redirect '/tweets'
		else
			erb :'/users/login'
		end
	end

	post '/login' do
		#binding.pry
		user = User.find_by(username: params["username"])
		#binding.pry

		if user && user.authenticate(params["password"])
			session[:id] = user[:id]
			redirect '/tweets'
		else
			redirect '/login'
		end
	end

	get '/logout' do
		session.clear
		redirect '/login'
	end

	get '/tweets/:id/edit' do
		erb :'/tweets/edit'
	end

	delete '/tweets/:id/delete' do
		tweet = Tweet.find_by_id(params[:id])
		if logged_in? && session[:id] == tweet.id
			tweet.delete
			redirect '/tweets'
		else
			redirect '/login'
		end
	end
end
