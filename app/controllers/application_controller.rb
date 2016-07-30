require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_application_secret"
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'tweets/user_tweets'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect to "/login"
    end

  end

  patch "/tweets/:id" do
    if !params[:content].empty?
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])
      redirect to "/users/#{current_user.slug}"
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end

  delete "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
      @tweet.delete
      redirect to "/users/#{current_user.slug}"
    else
      redirect to "/tweets/#{params[:id]}"
    end
  end


  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect to "/users/#{current_user.slug}"
    else
      redirect to "/tweets/new"
    end
    
  end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/login' do
    if logged_in?
      redirect to "tweets"
    else
      erb :'users/login'
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect to "/signup"
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