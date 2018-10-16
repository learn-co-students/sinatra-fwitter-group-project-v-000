require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_secured"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'/users/create_user'
  end
  get '/login' do
    erb :'/users/login'
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if params[:username] != "" && params[:password] != "" && params[:email] !=""
      @user.save
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get "/logout" do
    session.clear
    redirect "/"
  end
end
