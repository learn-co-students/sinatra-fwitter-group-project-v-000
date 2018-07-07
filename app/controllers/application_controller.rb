require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "ftweet"
  end

  get '/' do
    erb :index
  end

  get '/login' do
    redirect '/tweets' if logged_in?
    erb :"users/login"
  end
  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/failure"
    end
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  get '/signup' do
    redirect '/tweets' if logged_in?
    erb :"users/create_user"
  end
  post '/signup' do
    # fields required in erb but additional check for rspec (or if someone bypasses the form)
    if params[:username].length == 0 || params[:email].length == 0 || params[:password].length == 0
      redirect '/signup'
    end
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    redirect "/failure" if !user.save
    session[:user_id] = user.id
    redirect '/tweets'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end
  get '/failure' do
    erb :failure
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
