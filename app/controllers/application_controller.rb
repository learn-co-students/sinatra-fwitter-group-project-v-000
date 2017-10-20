require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "topsecret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    end
    erb :"/users/signup"
  end

  post "/signup" do
    if params.has_value?("")
      redirect "/signup"
    end
    @user = User.create(:username => params[:username], email: params[:email], :password => params[:password])
    session[:user_id] = @user.id
    redirect '/tweets'
  end

  get '/login' do
    if logged_in?
      redirect "/tweets/index"
    end
    erb :"/users/login"
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets/index"
    else
      redirect "/users/login"
    end
  end

  get '/tweets/index' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :"/tweets/index"
    else
    redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
  		session.clear
  		redirect "/login"
    else
      redirect "/"
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end

end
