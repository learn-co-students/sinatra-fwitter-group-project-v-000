require './config/environment'

class TweetController < ApplicationController
  get '/tweets' do
    if Helpers.logged_in?(session)
      @user = User.find_by_id(session[:user_id])

      erb :'/tweets/index'
    else
      redirect :'/login'
    end
  end

  get '/tweets/new' do
    if Helpers.logged_in?(session)
      @user = User.find_by_id(session[:user_id])

      erb :'/tweets/new'
    else
      redirect :'/login'
    end
  end

  post '/tweets' do
    if params[:content].blank?
      redirect :'/tweets/new'
    else
      @user = User.find_by_id(session[:user_id])
      @new_tweet = Tweet.create(:content => params[:content], :user_id => @user.id)
      @new_tweet.save

      erb :'/users/show'
    end
  end

  get '/tweets/:tweet_id' do
    if Helpers.logged_in?(session)
      @user = User.find_by_id(session[:user_id])
      @tweet = Tweet.find_by_id(params[:tweet_id])
      @tweeter = User.find_by_id(@tweet.user_id)

      erb :'tweets/show'
    else
      redirect :'/login'
    end
  end

  delete '/delete/:tweet_id' do
    @tweet = Tweet.find_by_id(params[:tweet_id])
    @tweeter = User.find_by_id(@tweet.user_id)
    
    if Helpers.current_user(session) == @tweeter
      @tweet = Tweet.find_by_id(params[:tweet_id])
      @tweet.delete
    end

    redirect :'/tweets'
  end
end
