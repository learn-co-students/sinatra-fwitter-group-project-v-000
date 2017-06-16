require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
   use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    if logged_in?
      redirect '/tweets'
    else
      erb :index
    end
  end

  get "/login" do
    if logged_in?
      redirect '/tweets'
    else
      erb :"/users/login"
    end
  end

  get "/signup" do
    if logged_in?
      flash[:notice] = "You're already logged in! Redirecting..."
      redirect '/tweets'
    else
      erb :"/users/create_user"
    end
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      flash[:error] = "You have missing required fields."
      redirect '/signup'
    else
      @user = User.new(params)
      @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Fwitter!"
      redirect '/tweets'
    end
  end


  post "/login" do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.username}!"
      redirect '/tweets'
    else
      flash[:error] = "Login failed!"
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :"/users/show"
  end

  get "/tweets/new" do
    @user = current_user
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect '/login'
    end
  end

  post "/new" do
    if logged_in? && params[:content] != ""
      @user = current_user
      @tweet = Tweet.create(content: params["content"], user_id: params[:user_id])
      @tweet.save
      erb :"/tweets/show_tweet"
    elsif logged_in? && params[:content] == ""
      flash[:notice] = "Your tweet is blank!"
      redirect '/tweets/new'
    else
      flash[:notice] = "Please log in to proceed"
      redirect '/login'
    end
  end

  get "/tweets" do
    if logged_in?
      @user = current_user
      erb :"/tweets/tweets"
    else
      redirect '/login'
    end
  end

  get "/tweets/:id" do
    @user = current_user
    @tweet = Tweet.find_by_id(params[:id])
    if !logged_in?
      redirect '/login'
    else
      erb :"/tweets/show_tweet"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == session[:user_id]
      erb :'/tweets/edit_tweet'
      else
        redirect '/login'
      end
    else
      redirect '/login'
    end
  end

  patch "/tweets/:id" do
    if params[:content] == ""
      flash[:notice] = "Please enter content to proceed"
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete "/tweets/:id/delete" do
    @user = current_user
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user_id == session[:user_id]
      @tweet.delete
      erb :'/tweets/delete'
    elsif !logged_in? || @tweet.user_id != session[:user_id]
      erb :'/tweets/error'
    else
      erb :'/tweets/error'
    end
  end


  get "/logout" do
    if logged_in?
      session.clear
      redirect '/login'
    else
      session.clear
      redirect '/'
    end
  end

  helpers do
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end
  end

end
