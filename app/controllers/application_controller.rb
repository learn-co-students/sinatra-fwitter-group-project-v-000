require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    enable :sessions
    set :session_secret, "seacret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/new"
    end
  end

  post '/signup' do
    user = User.new(params)
    if user.save && user.username != "" && user.email != ""
      session[:user_id] = user.id
      redirect "/tweets"
    else
      flash[:message] = "Please enter username, email, and password to Signup"
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/login"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      flash[:message] = "Please enter username, email, and password to Login"
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

  #will need to create two helper methods:
    #  #current_user & #logged_in?
    # to help prevent people from editing/deleting/creating tweets unless they are logged in as a specific user

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"tweets/index"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :"tweets/new"
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if logged_in? && params[:content] == ""
       redirect "/tweets/new"
    elsif logged_in?
       tweet = Tweet.create(params)
       tweet.user = current_user
       current_user.tweets << tweet
       current_user.save
       tweet.save
       redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && current_user == @tweet.user
      erb :"tweets/edit"
    elsif logged_in?
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  post '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params[:content] != ""
      tweet.content = params[:content]
      tweet.save
      redirect "/tweets/#{tweet.id}"
    else
      flash[:message] = "Edited tweets must contain text. Please click delete tweet to permanently remove tweet."
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    #delete tweet
    tweet = Tweet.find(params[:id])
    if logged_in? && current_user == tweet.user
      tweet.delete
    end
    redirect "/tweets"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
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
