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

  get '/signup' do
  	if session[:user_id] == nil
  		erb :'/users/create_users'
  	else
  		redirect to '/tweets'
 	 end
 	end

 post '/signup' do 
 	if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
 end

 get '/login' do
 	if session[:user_id] == nil
      erb :'/users/login'
    else
      redirect to '/tweets'
    end
 end

 post '/login' do
 	@user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to '/login'
    end
 end

end
