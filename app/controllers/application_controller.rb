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
      if session[:user_id]
        true
      else
        false
      end
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

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :'home/signup'
  end

  post '/signup' do
    if params[:user][:username].empty? || params[:user][:password].empty? || params[:user][:email].empty?
      redirect to '/signup'
    elsif !params[:user][:email].include?("@") || !params[:user][:email].include?(".")
      redirect to '/signup'
    else
      @user = User.create(params[:user])
      session[:user_id] = @user.id
      redirect to '/tweets'
    end

  end

  post '/login' do

    @user = User.find_by(username: params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end

  end

  get '/success' do
    @user = User.find_by_id(session[:user_id])
    erb :'home/success'
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end


end
