require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base
   register Sinatra::ActiveRecordExtension

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do

    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect("/tweets")
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if !params["username"].empty? && !params["email"].empty? && !params["password"].empty?
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect("/tweets")
    else
     redirect("/signup")
   end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/users/show'
    else
      redirect("/login")
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'/tweets/create_tweet'
    else
      redirect("/login")
    end
  end

  post '/tweets' do
    if logged_in? && !params["content"].empty?
      @tweet = Tweet.create(content: params["content"])
      @tweet.user_id = current_user.id
      @tweet.save
      redirect("/tweets")
    else
      redirect("/tweets/new")
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params["id"])

    erb :'/tweets/show_tweet'
  end

  get '/login' do
    if logged_in?
      @user = current_user
      redirect("/users/#{@user.slug}/tweets")
    else
    erb:'/users/login'
  end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user && @user.authenticate(params["password"])
      session[:user_id] = @user.id
      redirect("/tweets")
    else
      redirect("/tweets")
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect("/login")
    else
      redirect("/tweets")
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params["slug"])
    erb :'/users/show'
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
