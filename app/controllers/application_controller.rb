require 'pry'
require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "evelynwaugh"
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end

  get '/' do
    erb :'home/index'
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :'home/login'
  end

  post '/login' do

    user = User.find_by(username: params[:user][:username])

    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end

  end

  get '/logout' do
    session.clear
    redirect '/login'
  end


end
