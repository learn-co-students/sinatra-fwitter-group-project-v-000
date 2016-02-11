require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if is_logged_in?
      redirect 'tweets/tweets'
    else
      erb :'/user/create_user'
    end
  end

  post '/signup' do
    if (params[:username] == "" || params[:email]=="" || params[:password] =="")
     redirect '/signup'
   else
     @user = User.find_or_create_by(username: params[:username])
     @user.email = params[:email];
     @user.password = params[:password]
     session[:id] = @user.id
     @user.save
    redirect 'tweets/tweets'
    end
  end

  get '/login' do
    if !is_logged_in?
      erb :'user/login'
    else
    redirect 'tweets/tweets'
    end
  end

  post '/login' do
    #binding.pry
    @user = User.find_by(username: params["username"], password: params["password"])
    if @user.nil? == false
      #binding.pry
      session[:user_id] = @user.id
      @username = @user.username
      @tweets = @user.tweets
    redirect 'tweets/tweets'
  end

  end

  helpers do
    def is_logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end



end
