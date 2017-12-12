require './config/environment'
require "./app/models/user"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/' do
    erb :index
  end

  get "/signup" do
    if logged_in?
      redirect :"tweets/tweets"
    else
      erb :signup
    end
  end

  post "/signup" do
    # binding.pry
    user = User.new(username: params["username"], email: params["email"], password: params["password"])
    if params["username"] == "" || params["username"] == nil || params["email"] == "" || params["email"] == nil || params["password"] == "" || params["password"] == nil
      redirect "/signup"
    else
        user.save
        session[:user_id] = user.id
  			redirect :"tweets/tweets"
    end
  end

  get "/login" do
    if logged_in?
      redirect :"tweets/tweets"
    else
      erb :login
    end
  end

  post "/login" do
    # binding.pry
    user = User.find_by(username: params["username"])
    if user && user.authenticate(params["password"])
      session[:user_id] = user.id
        redirect :"tweets/tweets"
    end

  end

  # get "/logout" do
	# 	session.clear
	# 	redirect "/"
	# end

  helpers do
  		def logged_in?
  			!!session[:user_id]
  		end

  		def current_user
  			User.find(session[:user_id])
  		end
  end

end
