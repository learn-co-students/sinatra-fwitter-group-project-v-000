require './config/environment'
require "./app/models/user"

class ApplicationController < Sinatra::Base
  attr_accessor :slug

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :"index"
  end

  get "/signup" do
    erb :"users/create_user" 
  end

  post "/signup" do
    @user = User.create(username: params["username"], 
    password: params["password"], email: params["email"])
    if @user.save || logged_in?
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to '/signup'
    end
  end

  get "/login" do
    if logged_in?
      @user = current_user
      redirect to "/tweets"
    else  
      erb :"users/login"
    end
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to '/'  #homepage
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      #@tweets = Tweet.all.map do |tweet| 
       # if tweet.user_id.eql?(@user.id)
       #   erb :'tweets/tweets'
        #end
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'tweets/create_tweet'
    else
      redirect to '/' 
    end
  end

  post '/tweets/new' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.create(params[:tweet])
      @tweet.user_id = @user.id
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to '/' 
    end
  end

  get '/users/#{user.slug}' do
    if logged_in?
      @slug = params["user.slug"]
      binding.pry
      @user = User.find_by_slug(@slug)
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/' 
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == @user.id
        erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end    
    else
      redirect to '/login' 
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params["tweet"]["content"])
      @tweets =  Tweet.all
      redirect to '/tweets'
    else
      redirect to '/'  
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      @tweet.destroy
      erb :'tweets/tweets'
    else
      redirect to '/login' 
    end
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end
end