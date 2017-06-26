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

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/signup' do
    if session[:user_id] != nil
      redirect 'tweets/tweets'
    elsif params["username"] == "" || params["email"] == "" || params["password"] == ""
      redirect '/signup'
    else
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end


  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user
      if @user.authenticate(params[:password]) && @user.id != session[:user_id]
        session[:user_id] = @user.id
        redirect "/tweets"
      end
    else
      redirect "users/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/tweets' do
    erb :'tweets/tweets'
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
