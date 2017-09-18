require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :session unless test?
    set :session_secret, "secret"
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

  end

  get "/" do
    erb :index
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
      @user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
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
    @user = User.find_by_username(params[:username])
    if logged_in?
      session[:user_id] = @user.id
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
    erb :'tweets/new'
  end

  post "/tweets" do
    @tweet = Tweet.create(content: params[:content], user_id: params[:user_id])
    redirect "/tweets"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:user_id])
    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:user_id])
    erb :'tweets/edit'
  end

  patch '/posts/:id' do
    @tweet = Tweet.find_by_id(params[:user_id])
    @tweet.content = params[:content]
    @tweet.save
    erb :'tweets/show'
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:user_id])
    Post.delete(params[:id])
    erb :'tweets/delete'
  end

end
