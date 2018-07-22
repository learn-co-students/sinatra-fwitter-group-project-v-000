require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do #homepage index request
    erb :index
  end

  get '/signup' do #signup page request
    if !is_logged_in?
      erb :'/registrations/signup'
    else
      redirect :"/tweets"
    end
  end

  post '/signup' do #signup and redirect
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect :"/registrations/signup"
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect :"/tweets"
    end
  end

  get "/sessions/failure" do
    erb :"/sessions/failure"
  end

  get '/login' do #login page request
    erb :"/sessions/login"
  end

  post "/sessions" do #login and redirect
    @user = User.find_by(username: params["username"], password: params["password"])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect :"/tweets"
    else
      redirect :"/sessions/failure"
    end
  end

  get '/sessions/logout' do #logout
    session.clear
    redirect :"/sessions/login"
  end

  helpers do
		def is_logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end
