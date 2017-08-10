class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect "/login"
    else
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/tweets'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if !logged_in?
      redirect "/"
    elsif !params[:content].empty?
      @user = current_user
      @tweet = Tweet.create(content: params[:content])
      @user.tweets << @tweet
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:tweet_id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:tweet_id])
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:tweet_id/edit' do

    if session[:user_id]

      @user = current_user
      @tweet = Tweet.find(params[:tweet_id])
      erb :'/tweets/edit_tweet'
      #binding.pry
    else
      redirect "/login"
    end
  end

  patch '/tweets/:tweet_id' do

    @tweet = Tweet.find(params[:tweet_id])
    if !logged_in?
      redirect "/"
    elsif params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    elsif session[:user_id] != @tweet.user.id
      redirect "/tweets"
    else
      @tweet.update(content: params[:content])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:tweet_id' do
    @tweet = Tweet.find(params[:tweet_id])
    if !logged_in?
      redirect "/"
    elsif session[:user_id] != @tweet.user.id
      redirect "/tweets"
    else
      @tweet.destroy
      redirect "/tweets"
    end
  end
end
