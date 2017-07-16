require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
  	if !logged_in?
  		erb :index
  	else 
  		redirect '/tweets'
  	end 
  end 

  get '/signup' do 
  	# binding.pry
  	if !logged_in?
  		erb :'users/create_user'
  	else 
  		redirect '/tweets'
  	end 
  end 

  post '/signup' do
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])
    if @user.save
    	session[:id] = @user.id
    	redirect '/tweets'    #here can also put to redirect to login
    else 
		redirect '/signup'
	end 
  end

  get '/login' do
  	if !logged_in?
    	erb :'users/login'
    else 
    	redirect '/tweets'  
    end 	
  end

  post '/login' do
    user = User.find_by(username: params[:username])
	if user && user.authenticate(params[:password])
		session[:id] = user.id 
		redirect '/tweets'
	else 
		redirect '/login'
	end 
  end


  get '/logout' do 
	    session.clear
	    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end


	helpers do 

	  def logged_in?
	  	!!current_user
	  end

	  def current_user
	  	@current_user ||= User.find(session[:id]) if session[:id]
	  end 

	end 

end