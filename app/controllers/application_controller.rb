require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "wubbawubba"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:user_id]
      redirect to "/tweets"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:email] == "" || params[:username] == "" || params[:password] == ""
     redirect to "/signup"
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if session[:user_id]
      redirect to "/tweets"
    else
      erb :"users/login"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to "/"
    end
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/tweets' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      erb :'tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end
end
