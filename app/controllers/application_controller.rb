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

  get '/signup' do
    if session[:id]
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])
    if !params[:username].empty? && !params[:email].empty? && @user.save
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/tweets' do
    if session[:id]
      @user = User.find(session[:id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/login' do
    if session[:id]
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if session[:id]
      session.clear
      redirect '/login'
    else
      redirect to '/'
    end
  end

  get '/tweets/new' do
    if session[:id]
      erb :'/tweets/create_tweet'
    else
      redirect to '/'
    end
  end

  get '/users/:user_slug' do
    if session[:id]
      @user = User.find_by_slug(params[:user_slug])
      #binding.pry
      erb :'/users/show_user_tweets'
    else
      redirect to '/'
    end
  end

  post '/tweets' do
    if !session[:id]
      redirect to '/'
    elsif !params[:content].empty?
      @user = User.find(session[:id])
      @tweet = Tweet.create(content: params[:content])
      @user.tweets << @tweet
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to 'tweets/new'
    end
  end

  get '/tweets/:id' do
    if session[:id]
      @user = User.find(session[:id])
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/'
    end
  end


end
