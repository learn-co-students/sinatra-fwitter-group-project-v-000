require './config/environment'
require 'pry'

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

  get '/login' do
  	if !logged_in?
  		erb :'users/login'
  	else
  		redirect '/tweets'
  	end
  end

  post '/login' do
  	@user = User.find_by(username: params[:username])
  	if @user
  		session[:id] = @user.id
  		redirect '/tweets'
  	end
  	redirect '/login'
  end

  get '/logout' do
  	if logged_in?
	    session.clear
	    redirect "/login"
	  else
	  	redirect '/'
	  end
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