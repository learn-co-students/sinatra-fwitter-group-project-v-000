require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    if logged_in?
      redirect "/tweets"
    else
      erb :'index'
    end
  end

  get "/tweets" do
    if logged_in?
      erb :'tweets/tweets'
    else
      redirect "/login"
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    tweet = Tweet.new(content: params[:content], user_id: current_user.id)
    if tweet.save
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find(params[:id])          
      erb :'tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  post "/tweets/:id" do
    tweet = Tweet.find(params[:id])
    tweet.update(content: params[:content])
    if tweet.save
      redirect "/tweets/#{params[:id]}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  post "/tweets/:id/delete" do
    tweet = Tweet.find(params[:id])    
    if logged_in? && tweet.user_id == current_user.id
      tweet.delete
      redirect "/tweets"
    else
      redirect "/tweets/#{params[:id]}"
    end
  end

  # Sign Up
  get "/signup" do
    if logged_in?
      redirect "/tweets"
    else
      erb :'users/create_user'
    end
  end

  post "/signup" do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save
      session[:user_id] = user.id      
      redirect "/tweets" 
    else
      redirect "/signup"
    end
  end

  get "/login" do

    if logged_in?
      redirect "/tweets"
    else
      erb :'users/login'
    end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  def current_user
    User.find(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end
  
end