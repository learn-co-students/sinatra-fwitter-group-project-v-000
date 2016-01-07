require './config/environment'

require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "upupdowndownleftrightleftrightabselectstart"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :"users/signup"
    else
      redirect "/tweets"
    end
  end

  post '/signup' do
    user = User.new(username: params["username"], email: params["email"], password: params["password"])
    if !user.username.empty? && !user.email.empty? && user.save
      session[:id] = user.id
      redirect to "/tweets"
    elsif params["username"].empty? || params["email"].empty?
      redirect to "/signup", :locals => {:missing => "Please fill in all fields"}
    else
      redirect to "/signup", :locals => {:error => "Not a valid username/password. Please try again"}
    end
  end

  get '/login' do 
    if !logged_in?
      erb :"users/login"
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    if !params["username"].empty?
      user = User.find_by(username: params["username"])
      if !!user && user.authenticate(params["password"])
        session[:id] = user.id  
        redirect to "/tweets"
      end
    else
      redirect to "/login"
    end
  end

  get "/tweets" do
    if logged_in?
      @tweets = Tweet.all
      erb :"tweets/index"
    else
      redirect to '/login'
    end
  end

  get "/logout" do 
    session.clear
    redirect to '/login'
  end

  get "/users/:slug" do
    erb :"users/show" if params[:slug] == current_user.slug
  end

  get "/tweets/new" do 
    if logged_in?
      erb :"tweets/new"
    else
      redirect to "/login"
    end
  end

  post "/tweets" do
    if logged_in?
      if !params["content"].empty?
        @new_tweet = Tweet.create(content: params["content"], user_id: session[:id])
        redirect to "/tweets"
      else
        redirect to "/tweets/new"
      end
    else
      redirect to "/login"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show"
    else
      redirect to "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      if @user.id == @tweet.user_id
        erb :"tweets/edit"
      else
        redirect to "/tweets/#{params[:id]}"
      end
    else
      redirect to "/login"
    end
  end

  post "/tweets/:id" do
    if logged_in?
      if !params["content"].empty?
        @tweet = Tweet.find(params[:id])
        @tweet.update(content: params["content"])
      else
        redirect to "/tweets/#{params[:id]}/edit"
      end
    else
      redirect to "/login"
    end
  end

  post "/tweets/:id/delete" do
    if logged_in?
      @tweet= Tweet.find(params[:id])
      if @tweet.user_id == session[:id]
        @tweet.destroy
        redirect to "/tweets"
      else
        redirect to "/tweets"
      end
    else
      redirect to "/login"
    end
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