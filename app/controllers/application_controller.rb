require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get "/" do
  	erb :index
  end

  get "/signup" do
  	if !!session[:id]
  		redirect "/tweets"
  	else
  		erb :"users/create_user"
  	end
  end

  post "/signup" do
  	if params[:username] == "" || params[:email] == "" || params[:password] == ""
  		redirect "/signup"
  	else
  		user = User.create(params)
  		session[:id] = user.id
  	end
  	redirect "/tweets"
  end

  get "/login" do 
  	if !!session[:id]
  		redirect "/tweets"
  	else
  		erb :"users/login"
  	end
  end

  post "/login" do
  	user = User.find_by(params)
  	session[:id] = user.id
  	redirect "/tweets"
  end

  get "/tweets" do 
  	if !!session[:id]
  		erb :"tweets/tweets"
  	else
  		redirect "/login"
  	end
  end

  get "/logout" do 
  	session.clear
  	redirect "/login"
  end
end