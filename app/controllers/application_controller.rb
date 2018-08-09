require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
		
		enable :sessions
		set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

	get '/login' do
		if logged_in?
			redirect to '/tweets'
		else
			erb :login
		end
	end
	
	post '/login' do
		user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tweets"
    else
        redirect "/login"
    end
	end
  
	get '/signup' do
		if logged_in?
			redirect to '/tweets'
		else
			erb :signup
		end
  end

	post '/signup' do
		if params[:username].empty? || params[:email].empty? || params[:password].empty?
			redirect to '/signup'
		else
			@user = User.create(params)
			session[:user_id] = @user.id
			redirect to '/tweets'
		end
	end

  get "/logout" do
    if logged_in?
			session.clear
			redirect '/login'
		else
			redirect to '/login'
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
