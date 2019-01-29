require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "3lklk2ml23-0op;l"
    enable :sessions
  end

  get '/' do
    
  	erb :index
  end

  get '/login' do
  	if logged_in?
  		redirect '/tweets'
  	else
  		erb :'users/login'
  	end
  end

  get '/logout' do
  	if !logged_in?
  		redirect '/login'
  	else
  		session.clear
  		redirect '/login'
  	end
  end

  get '/signup' do
  	
  	if logged_in?
  		redirect '/tweets'
  	else
		erb :'users/create_user'
	end
  end

  post '/signup' do
  	@user = User.new(params)

  	if !@user.save
		redirect '/signup'
	else
		session[:user_id] = @user.id
		redirect '/tweets'
	end
  end

  post '/login' do
  	user = User.find_by(:username => params[:username])
  	
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect '/tweets'
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
