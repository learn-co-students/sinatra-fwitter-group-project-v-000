require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/signup'
    end   
  end

  post '/signup' do
    @user = User.new(params)

    if !@user.username.empty? && !@user.email.empty? && @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      # below would be better, but test does not allow
      # erb :'/users/signup', locals: {message: "Missing a required field."}
      redirect '/signup'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      erb :'users/login', locals: {message: "Incorrect username and/or password."}
    end
  end

  get '/failure' do
    erb :'users/failure'
  end

  get '/tweets' do
    @user = current_user
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