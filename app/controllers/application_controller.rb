require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
    erb :signup
    end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/index'
    else
      redirect "/login"
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect "/signup"
    else
      @user = User.create(username: params[:username], email: params[:email],password: params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/tweets"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(:slug)

    erb :'users/show'
  end


  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end

end
