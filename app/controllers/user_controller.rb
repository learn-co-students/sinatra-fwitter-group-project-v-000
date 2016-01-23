class UserController < ApplicationController

	get '/info' do  
		out=""
		out << ("\nsession id: "+session[:id].to_s)
		User.all.each do |user|
			out << ("<br>User #{user.id.to_s}: "+user.username)
		end
		out

	end

	get '/logout' do  
		session.clear
		redirect '/login'
	end

	get '/login' do  
		if Helpers.logged_in?(session)
			#puts "ALREADY LOGGED IN"
			redirect '/tweets'
		else
			erb :'user/login'
		end
	end


	post '/login' do  
		if Helpers.logged_in?(session)
			#puts "ALREADY LOGGED IN"
			redirect '/tweets'
		else
			if Helpers.valid_login(params) # makes 2 db queries... unnecesary
				Helpers.login_by_params(params, session)
				redirect '/tweets' 
			else
				redirect '/login'
			end
		end
	end

	get '/signup' do  
		#puts "get request to /signup"
		#puts session
		if Helpers.logged_in?(session)
			#puts "ALREADY LOGGED IN"
			redirect '/tweets'
		else
			erb :'user/signup'
		end
	end

	post '/signup' do 
		#puts "posted to /signup"
		if Helpers.logged_in?(session)
			#puts "ALREADY LOGGED IN"
			redirect '/tweets'
		end

		if Helpers.signup_params_valid?(params)
			user=User.create(username: params[:username], password: params[:password], email: params[:email])
			#binding.pry
			Helpers.login(user, session)
			#puts session
			redirect '/tweets'
		else
			#puts "INVALID SIGNUP INFO"
			redirect '/signup'
		end
	end

	###################USER SPECIFIC#################################

	get '/users/:slug' do 
		@user=User.find_by_slug(params[:slug])
		#binding.pry
		erb :'user/profile'
	end

end