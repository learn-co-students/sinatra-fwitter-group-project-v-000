require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user = User.find(session[:user_id])
    end
  end

  get '/' do
    if !session[:user_id]
      erb :home
    else
      redirect to 'tweets/tweets'
    end
  end

  get '/signup' do
    if !session[:user_id]
      erb :signup
    else
      redirect to '/tweets'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :login
    else
      redirect to '/tweets'
    end
  end

  get '/failure' do
    erb :failure
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to "/tweets"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/failure"
    end
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect to "/login"
    else
      redirect to '/'
    end
  end

end
