require 'pry'
require './config/environment'

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

  get '/users/:slug' do
    @user = User.find_by_slug(:slug)
    erb :'/users/show'
  end

  get "/signup" do
    if session[:user_id]
      redirect "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  post "/signup" do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])

    if !params[:username].empty? && !params[:email].empty? && @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/tweets' do
    if !session[:user_id]
      redirect "/login"
    else
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets'
    end
  end

  get '/login' do
    if session[:user_id]
      redirect "/tweets"
    else
      erb :'/users/login'
    end
  end

  post '/login' do

    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])

      session[:user_id] = @user.id

      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

  get '/tweets/new' do
    if session[:user_id]
      erb :'/tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if !session[:user_id]
      redirect "/"
    elsif !params[:content].empty?
      @user = User.find(session[:user_id])
      @tweet = Tweet.create(content: params[:content])
      @user.tweets << @tweet
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:tweet_id' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      @tweet = Tweet.find(params[:tweet_id])
      erb :'/tweets/show_tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/:tweet_id/edit' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      @tweet = Tweet.find(params[:tweet_id])
      erb :'/tweets/edit_tweets'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:tweet_id' do
  @tweet = Tweet.find(params[:tweet_id])
    if !session[:user_id]
      redirect "/"
    elsif session[:user_id] =! @tweet.user.id
      redirect "/tweets"
    elsif params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      @tweet.save
      redirect "/tweets/#{@tweet.id}}"
    end
  end

  delete '/tweets/:tweet_id' do
    @tweet = Tweet.find(params[:tweet_id])
    if !session[:user_id]
      redirect "/"
    elsif session[:user_id] != @tweet.user.id
      redirect "/tweets"
    else
      @tweet.destroy(@tweet.id)
    end
  end


end
