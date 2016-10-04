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
		if logged_in?
			erb :'tweets/tweets'
		else
			redirect '/login'
		end
	end

	get '/signup' do 
		if self.logged_in?
			redirect '/tweets'
		else
			erb :'users/create_user'
		end
	end

	get '/login' do
		if logged_in?
			redirect '/tweets'
		else
			erb :'users/login'
		end
	end


	post '/signup' do 
		@user = User.new
		@user.username = params[:username]
		@user.email = params[:email]
		@user.password = params[:password]
		if @user.save
			session[:id] = @user.id
			redirect '/tweets'
		else
			redirect '/signup'
		end
	end

	post '/login' do
		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			session[:id] = @user.id
			redirect '/tweets'
		else
			redirect '/'
		end
	end

	helpers do
		def logged_in?
		  !!session[:id]
		end

		def current_user
		  User.find(session[:id])
		end
	end

end