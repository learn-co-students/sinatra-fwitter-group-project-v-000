require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  helpers do
   def logged_in?
     !!current_user
   end

   def current_user
     @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
   end
 end

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params["username"] != "" && params["email"] != "" && params["password"] != ""
      @user = User.create(params)
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
    redirect to '/signup'
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    session[:user_id] = @user.id
    redirect to '/tweets'
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/tweets' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets/new' do
    if logged_in?
      if params[:content] != ""
        @tweet = Tweet.create(params)
        @tweet.user_id = session[:user_id]
        @tweet.save
      end
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to '/login'
    end
  end

  get "/users/:slug" do
    erb :'/users/show'
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  post "/tweets/:id/edit" do
    if logged_in?
      if params[:content] != ""
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.content = params[:content]
        @tweet.save
      end
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to '/login'
    end
  end

  get "/tweets/:id/delete" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
        @tweet.delete
      end
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end


end
