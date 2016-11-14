require './config/environment'
require "pry"
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "time again"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/create_user"
    end
  end

  post "/signup" do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      session[:id] = @user.id

      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get "/login" do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/login"
    end
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/tweets/new" do
    erb :"tweets/create_tweet"
  end

  post "/tweets" do
    @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    redirect "/tweets"
  end

  get "/tweets" do
    if logged_in?
      erb :"tweets/tweets"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

  end

end
