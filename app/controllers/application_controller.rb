require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'users/create_user'
    end
  end

  post "/signup" do
    @user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
		if @user.save
      session[:user_id] = @user.id
			redirect "/tweets"
		else
			redirect "/signup"
		end
	end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'users/login'
    end
  end

  post "/login" do
		user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect "/tweets"
		else
			redirect "/signup"
		end
	end

  get '/tweets' do
    if logged_in?
     erb :'tweets/tweets'
   else
     redirect "/login"
   end
  end

  get "/logout" do
    if logged_in?
  		session.clear
  		redirect "/login"
    else
      redirect "/login"
		end


  end

  helpers do
    def current_user
      User.find_by_id(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

  end

end
