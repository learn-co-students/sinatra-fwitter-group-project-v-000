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
    if logged_in?
      redirect to "/tweets"
    else
      erb :"/users/create_user"
    end
  end

  post '/signup' do
    if params["username"] != "" && params["email"] != "" && params["password"] != ""
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/login' do
    erb :"users/login"
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user && @user.authenticate(params["password"])
        session[:id] = @user.id
        redirect to "/tweets"
    else
        redirect to "/signup"
    end
  end

  get '/tweets' do
    if logged_in?
      erb :"tweets/tweets"
    else
      redirect to "/login"
    end
  end

  helpers do
    def current_user
      User.find(session[:id])
    end

    def logged_in?
      !!(session[:id])
    end
  end

end
