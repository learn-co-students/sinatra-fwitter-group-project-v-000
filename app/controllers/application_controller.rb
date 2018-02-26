require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "fW1tT3r"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  use Rack::Flash

  helpers do
    def logged_in?
      !current_user.nil?
    end

    def verify_user
      if logged_in?
        current_user
      else
        flash[:message] = "Please log in to view tweets."
        redirect to "/login"
      end
    end

    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    def logout!
      session.clear
    end
  end

  get '/' do
    @current_user = current_user
    @tweets = Tweet.all
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :"users/create_user"
    end
  end

  get '/login' do
    if !logged_in?
      erb :"/users/login"
    else
      redirect to "/tweets"
    end
  end

  get '/logout' do
    if logged_in?
      logout!
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  post '/signup' do
    # refactor with authenticate
    # if User.find_by(username: params[:username]) || User.find_by(email: params[:email])
    #   flash[:message] = "This username and/or email already exists. Please try again."
    #   redirect to "/signup"
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(params)
      session[:user_id] = @user.id
    else
      flash[:message] = "You must have a username, email, and password in order to sign up. Please try again."
      redirect to "/signup"
    end

    redirect to "/tweets"
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user.nil?
      flash[:message] = "Could not find an account with the username you entered. Please try again."
      redirect to "/login"
    elsif @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      flash[:message] = "You have entered an incorrect password. Please try again."
      redirect to "/login"
    end
  end

end
