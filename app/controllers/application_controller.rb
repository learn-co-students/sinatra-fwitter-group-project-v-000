  require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    erb :"user/home"
  end

  get "/signup" do
    if !logged_in?
      erb :"/user/signup"
    else
      redirect "/tweets"
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
    if !logged_in?
      erb :"/user/login"
    else
      redirect "/tweets"
    end
  end

  post "/login" do
    if !params[:username].empty? && !params[:password].empty?
      @user = User.find_by(username: params[:username], password: params[:password])
      session[:id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/tweets" do
    if !logged_in?
      redirect "/login"
    else
      @user = User.find(session[:id])
      erb :"/user/tweets"
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :"/user/new_tweet"
    else
      redirect "/login"
    end
  end

  post "/tweets/new" do
    if !params[:content].blank?
      @tweet = Tweet.create(params)
      @user = User.find(session[:id])
      @user.tweets << @tweet
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @user = User.find(session[:id])
      @tweet = @user.tweets.find(params[:id])
      erb :"/user/user_single_tweet"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/user/edit_tweet"
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id/edit" do
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    @tweet.save
  end

  delete "/tweets/:id/delete" do
    @user = User.find(session[:id])
    @tweet = Tweet.find(params[:id])
    if @user.tweets.include?(@tweet)
      @tweet.delete
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
    erb :"/user/user_tweets"
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end

end
