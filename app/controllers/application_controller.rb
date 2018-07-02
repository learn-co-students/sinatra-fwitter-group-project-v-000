require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'pink'
  end
  	 helpers do 
  	 # 	methods go in here that will be utilized thorughout other controllers
  	 # set current user, checking if user is logged in
  	 # logged in - checked for user logged in
  	 # ? at the end of method name - returns t-any truthy or falsey value (example nil=false) truthy = array, not falsey (boolean -t/f)
  	def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
  	end


  	get '/' do
    	erb :'index'
  	end

  	get '/signup' do
  		if logged_in?
  			redirect to '/tweets'
		else
			erb :'/users/create_user'
		end
  	end

  	post '/signup' do	
  		if params["username"].empty? || params["password"].empty? || params["email"].empty?
  			redirect '/signup'
  		else
  			user = User.create(username: params["username"], password: params["password"], email: params["email"])
  			session[:user_id] = user.id
  			redirect to '/tweets'
  		end

  	end



end
