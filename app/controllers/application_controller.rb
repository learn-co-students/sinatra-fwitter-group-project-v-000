require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "abcdefghijklmnop"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find_by(id: session[:user_id])
    end
  end


  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/create_user"
    end
  end

  post '/signup' do
    redirect "/users/signup" if params[:username] == "" || params[:email] == "" || params[:password] == ""

    user = User.new
    user.username = params[:username]
    user.email = params[:email]
    user.password = params[:password]
    user.save
    session[:user_id] = user.id

    redirect "/tweets"
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/login"
    end
  end 

  post '/login' do
    redirect "/users/login" if params[:username] == "" || params[:password] == ""
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets' do
    @user = User.find_by(id: session[:user_id])

    erb :"tweets/tweets"
  end
end