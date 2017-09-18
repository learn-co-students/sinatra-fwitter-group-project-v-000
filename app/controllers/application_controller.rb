require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get "/" do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end
  end

  get "/signup" do
    if !logged_in?
      erb :signup
    else
      redirect "/tweets"
    end
  end

  post "/signup" do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect "/signup"
    else
      user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      user.save
      session[:user_id] = user.id
      redirect "/tweets"
    end
  end

  get "/login" do
    if !logged_in?
      erb :login
    else
      redirect "/tweets"
    end
  end

  post "/login" do
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

  get "/tweets" do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect "/login"
    end
  end

  get "/tweets/new" do
    if !logged_in?
      redirect "/login"
    else
      erb :'tweets/new'
    end
  end

  post "/tweets" do
    if params[:content].empty?
      redirect "/tweets/new"
    else
      tweet = Tweet.create(content: params[:content])
      tweet.user_id = session[:user_id]
      tweet.save
      redirect "/tweets"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:user_id])
      erb :'tweets/edit'
    else
      redirect "/login"
    end
  end

  patch '/posts/:id' do
    @tweet = Tweet.find_by_id(params[:user_id])
    @tweet.content = params[:content]
    @tweet.save
    erb :'tweets/show'
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(session[:user_id])
      Post.delete(session[:user_id])
      erb :'tweets/delete'
    else
      redirect "/login"
    end
  end

end
