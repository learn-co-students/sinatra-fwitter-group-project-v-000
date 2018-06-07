require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  register Sinatra::ActiveRecordExtension

  enable :sessions
  set :session_secret, "my_application_secret"

  set :views, Proc.new { File.join(root, "../views/") }
  # register Sinatra::Twitter::Bootstrap::Assets

  helpers do

    def current_user
      @user = User.find_by(id: session[:user_id])
    end


    def is_logged_in?
      !!session[:user_id]
    end

  end

  get '/' do
    erb :'../index'
  end

  get '/signup' do

    if is_logged_in?
      redirect '/tweets'
    else
      erb :'../signup'
    end
  end

  get '/login' do
    erb :'../login'
  end

  post '/login' do
    if @user = User.find_by(params)
      session[:user_id] = @user.id

      redirect '/tweets'
    else
      erb :'/errors/login_error'
    end
  end

  post '/signup' do
    if is_logged_in?
      redirect '/tweets'
    end

    if !!@user = User.find_by(params)
      redirect to '../login'
    end
    @user = User.create(params)
    if @user.id == nil
      erb :'/errors/signup_missing_error'
    else
      session[:id] = @user.id
      redirect '/tweets'
    end
  end

  get '/logout' do
    session.clear

    redirect to '/'
  end
end
