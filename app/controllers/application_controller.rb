require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      erb :'tweets/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      @user.save
      session[:user_id] = @user.id
    redirect "user/show"
  end

  get '/login' do
    if logged_in?
      erb :'tweets/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.# IDEA:
      redirect "tweets/tweets"
    else
      redirect "users/login"
    end
  end

  get '/logout' do
    session.clear
    erb :logout
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
