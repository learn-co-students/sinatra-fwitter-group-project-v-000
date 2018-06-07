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

  get '/' do
    erb :'../index'
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'../signup'
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'../login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user & @user.authenticate(params[:password])
      session[:user_id] = @user.id

      redirect '/tweets'
    else
      redirect '/errors/login'
    end
  end

  post '/signup' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    end
    if !!@user = User.find_by(params)
      redirect '../login'
    end
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if @user.id == nil
      redirect '/errors/signup'
    else
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/logout' do
    session.clear

    redirect to '/'
  end
end
