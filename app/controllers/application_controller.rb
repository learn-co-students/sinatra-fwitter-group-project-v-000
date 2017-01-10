require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:id] then redirect "/tweets" end
    erb :"/users/create_user"
  end

  get '/tweets' do
    if !session[:id] then redirect "/login" end
    @user=User.find(session[:id])
    erb :"/tweets/tweet"
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  post '/signup' do
    if params[:email]=="" then redirect "/signup" end
    if params[:username]=="" then redirect "/signup" end
    if params[:password]=="" then redirect "/signup" end
    @user=User.create(params)
    session[:id] = @user.id
    redirect "/tweets"
  end

  get '/login' do
    if session[:id] then redirect "/tweets" end
    erb :"/users/login"
  end

  post '/login' do
    user= User.find_by(username: params[:username])
    # redirect "/tweets"
    if user && user.authenticate(params[:password])
      session[:id]=user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end
end
