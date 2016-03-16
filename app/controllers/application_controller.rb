require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "super_application_secret"
  end

  get "/" do 
    erb :index
  end

  get "/signup" do 
    if logged_in?
      redirect to "/tweets"
    end
    erb :"/users/create_user"
  end

  post "/signup" do 
    if params["username"] == "" || params["email"] == "" || params["password"] == ""
      redirect to "/signup"
    else
      @user = User.create(params)
      session[:id] = @user.id # log in the user after they sign up
      redirect to "/tweets"
    end
  end

  get "/login" do #form for logging in
    if logged_in?
      erb :'/tweets/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do #authenticates user & pass and redirects
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  helpers do
    def logged_in?
      !!sessions[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end


end