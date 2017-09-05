class UsersController < ApplicationController

	get '/' do
		erb :index
	end

	get '/signup' do
		if logged_in?
			redirect to '/tweets' 
		end
		erb :'users/signup'
	end

	post '/signup' do
		if !params["username"].empty? && !params["email"].empty? && !params["password"].empty?	
			@user = User.create(params)
			session[:id] = @user.id	
		else
			redirect to '/signup'
		end	
				
		redirect to :'/tweets'
	end

	get '/login' do
		if logged_in?
			redirect to '/tweets'
		end
		erb :'users/login'
	end

	get '/logout' do
		if logged_in?
			session.clear
			redirect to '/login'
		else
			redirect to '/'
		end
	end

	post '/login' do
		if @user = User.find_by(:username => params[:username]).try(:authenticate, params[:password])   
			session[:id] = @user.id
		else
			redirect to '/signup'
		end
		redirect to '/tweets'
	end

	

end