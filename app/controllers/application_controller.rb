require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
  	erb :home
  end

  get '/signup' do
  	if signed_in?
  		redirect '/tweets'
  	else
  		erb :signup
  	end
  end
  
  post '/signup' do

  		if Helpers.valid_submission(params)
  			 @user = User.create(username: params[:username], email: params[:email], password: params[:password])
  			session[:id] = @user.id
  			redirect '/tweets'
  		else
  			redirect '/signup'
  		end
  	
  end


  get '/login' do
    if !signed_in?
       erb :login
	else
		redirect '/tweets'
	end
  end
  
  post '/login' do
    @user = User.find_by(username: params[:username])
  		if @user.authenticate(params[:password])
  			session[:id] = @user.id
    		redirect '/tweets'
    	else
    		erb :login
    	end
  end
  
  get '/logout' do
  	if signed_in?
  		session.clear
  		redirect '/login'
  	else
  		redirect '/'
  	end
  end
  

  

  helpers do
  	def signed_in?
		!!session[:id]
	end
  	
  	def valid_submission
		!params[:username].empty? && !params[:email].empty? && !params[:password].empty?
	end
  	
  end

end