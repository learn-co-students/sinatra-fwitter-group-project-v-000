require './config/environment'

class ApplicationController < Sinatra::Base

	configure do
		set :public_folder, 'public'
		set :views, 'app/views'
		enable :sessions
		set :session_secret, "password_security"
	end

	get '/' do 
		erb :index
	end

	get '/tweets' do 
		erb :'tweets/tweets'
	end

	get '/signup' do 
		if self.logged_in
			redirect '/tweets'
		else
			erb :'users/create_user'
		end
	end

	post '/users' do 
		@user = User.new
		@user.username = params[:user][:username]
		@user.email = params[:user][:email]
		@user.password = params[:user][:password]
		if @user.save
			redirect '/tweets'
		else
			redirect '/signup'
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