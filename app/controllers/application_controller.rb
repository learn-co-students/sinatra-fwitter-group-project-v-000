require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions unless test?
    set :session_secret, "fwitter_secret_sessions"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  use Rack::Flash

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    @user = User.new params[:user]
    if @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      flash[:message] = "Username or email not unique, please try again"
      redirect '/signup'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by email: params[:user][:email]
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      flash[:message] = "Incorrect email/password match, please try again."
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/tweets' do
    erb :'tweets/tweets'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find session[:user_id]
    end
  end
end
