class UserController < ApplicationController

	get "/users/:slug" do 
			@user = User.find_by_slug(params[:slug])
			erb :'/users/show'
	end

	get '/signup' do 

		if logged_in?
			redirect to "/tweets"
		else
			if session[:valid?] == false
				@valid = false
				session[:valid?] = true
			# elsif session[:exist?]
			# 	@exist = true
			# 	session[:exist?]	
			end

			erb :'/users/create_user'

		end
	end

	post '/signup' do 
		# if !!User.find_by(name: params[:username])
			user = User.new(username: params[:username], email: params[:email], password: params[:password])
		# else 
		# 	session[:exist?] = true
		# 	redirect to "/signup"
		# end

		if user.save
			user.save
			session[:user_id] = user.id
			redirect to "/tweets"

		else
			session[:valid?] = false
			redirect to'/signup'
		end
	end

	get '/login' do 
		if logged_in?
			redirect '/tweets'
		else	

			
			if session[:valid?] == false
				@valid = false
				session[:valid?] = true
			end

			erb :'/users/login'
		end
	end

	post '/login' do 
		user = User.find_by(:username => params[:username])
		
		if user && user.authenticate(params[:password])
			 session[:user_id] = user.id
			 redirect to '/tweets'
		else
			session[:valid?] = false

			redirect '/login'
		end
	end

	get '/logout' do 

		if logged_in?
			session.clear

			redirect '/login'
		else
			redirect "/"
		end
	end
end