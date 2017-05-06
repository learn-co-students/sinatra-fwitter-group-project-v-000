require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'totally_secure_key'
  end

  get "/" do
    if logged_in?
      redirect "/tweets"
    else
      erb :index
    end
  end

  get "/signup" do
    if logged_in?
      redirect "/tweets"
    else
      erb :signup
    end
  end

  post "/signup" do
    user = User.new(params)
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
      erb :login
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
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

  get "/tweets" do
    as_logged_in do
      @tweets = Tweet.all
      erb :'tweets/index'
    end
  end

  post "/tweets" do
    as_logged_in do |user|
      tweet = Tweet.new(content: params[:content], user: user)
      if tweet.save
        redirect "/tweets"
      else
        redirect "/tweets/new"
      end
    end
  end

  get "/tweets/new" do
    as_logged_in do
      erb :'tweets/new'
    end
  end

  get "/tweets/:id" do
    as_logged_in do |user|
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    end
  end

  patch "/tweets/:id" do
    as_logged_in do |user|
      @tweet = Tweet.find(params[:id])
      if user==@tweet.user && @tweet.update(content: params[:content])
        redirect "/tweets/#{params[:id]}"
      else
        redirect "/tweets/#{params[:id]}/edit"
      end
    end
  end

  delete "/tweets/:id" do
    as_logged_in do |user|
      @tweet = Tweet.find(params[:id])
      if user==@tweet.user && @tweet.delete
        redirect "/tweets"
      else
        redirect "/tweets/#{params[:id]}"
      end
    end
  end

  get "/tweets/:id/edit" do
    as_logged_in do |user|
      @tweet = Tweet.find(params[:id])
      if user==@tweet.user
        erb :'tweets/edit'
      else
        redirect "/tweets/#{params[:id]}"
      end
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  helpers do
    def logged_in?
      session[:user_id]!=nil
    end

    def current_user
      User.find(session[:user_id])
    end

    def as_logged_in
      if logged_in?
        yield(current_user)
      else
        redirect "/login"
      end
    end
  end

end
