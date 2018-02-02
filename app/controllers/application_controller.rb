require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def is_logged_in?
    #binding.pry
    session[:user_id] != nil
  end

  get '/' do
    erb :'/application/index'
  end

  get '/signup' do
     #binding.pry
    if self.is_logged_in?
  #    binding.pry
    redirect '/tweets'
  else
    erb :'/application/signup'
  end
  end

  post '/signup' do
    redirect '/signup' if params["username"].empty?
    redirect '/signup' if params["email"].empty?
    redirect '/signup' if params["password"].empty?
    @session = session
    @user = User.create(username: params["username"], email: params["email"], password: params["password"])
    #if @user.save
      @session[:user_id] = @user.id
      redirect '/tweets'
    #else
    #  redirect '/signup'
    #end
  end

  get '/login' do
    if self.is_logged_in?
  #    binding.pry
    redirect '/tweets'
  else
    erb :'application/login'
  end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    @session = session
    @session[:user_id] = @user.id
    redirect '/tweets'
  end

  get '/logout' do
    if self.is_logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

end
