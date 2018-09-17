class UsersController < ApplicationController

	get '/signup' do 
		erb :'/users/create_user'
	end

	post '/signup' do
		user = User.new(:email => params[:email], :username => params[:username], :password => [:password])

		if user.save
			redirect "/"
		else
			redirect "/failure"
		end
	end



	helpers do 
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end
