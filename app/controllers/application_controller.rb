require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    enable :sessions
    set :session_secret, "seacret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/new"
    end
  end

  post '/signup' do
    user = User.new(params)
    if user.save && user.username != "" && user.email != ""
      session[:user_id] = user.id
      redirect "/tweets"
    else
      flash[:message] = "Please enter username, email, and password to Signup"
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/login"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      flash[:message] = "Please enter username, email, and password to Login"
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

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
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
