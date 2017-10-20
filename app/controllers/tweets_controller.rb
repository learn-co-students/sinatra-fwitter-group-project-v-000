require 'pry'
class TweetsController < ApplicationController

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end

    get '/tweets' do
      if logged_in?
        @user = User.find_by_id(session[:user_id])
        erb :"/tweets/tweets"
      else
        redirect "/login"
      end
    end

    get '/tweets/new' do
      erb :"/tweets/create_tweet"
    end

    get '/tweets/' do
      @tweet = Tweet.find_by_id(params[:user_id])
      erb :"/tweets/show_tweet"
    end

    post '/tweets' do
      @tweet = Tweet.create(content: params[:tweet][:content])
      redirect "/tweets"
    end




end
