require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    redirect to "/tweets" if logged_in? #redirects if user logged_in
    erb :"users/new"
  end

  post "/signup" do
    user = User.new(params)
    if user.save  #validates presence of username & password
      session[:user_id] = user.id
      redirect to "/tweets"
    end
    redirect to "/signup" #redirects if user creation fails
  end

  get "/login" do
    redirect to "/tweets" if logged_in? #redirects if user logged_in
    erb :"users/login"
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password]) #validates username & password
      session[:user_id] = user.id
      redirect to "/tweets"
    end
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect to "/login"
    end
    redirect to "/" #redirects if user not logged_in
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def current_tweet
      Tweet.find_by_id(params[:id])
    end

    def logged_in?
      !!session[:user_id]
    end

    def all_tweets
      Tweet.all
    end
  end

end
