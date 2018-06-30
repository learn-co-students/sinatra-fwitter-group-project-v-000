class TweetsController < ApplicationController

  get '/tweets' do
    if session.has_key?(:user_id)
      @user = User.find(session[:user_id])
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if session.has_key?(:user_id)
      @user = User.find(session[:user_id])
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      tweet = Tweet.new(content: params[:content])
      user = User.find(session[:user_id])
      user.tweets << tweet
      user.save
      redirect "/tweets/#{tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:tweet_id' do
    if session.has_key?(:user_id)
      @tweet = Tweet.find(params[:tweet_id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  post '/tweets/:tweet_id/delete' do
    tweet = Tweet.find(params[:tweet_id])
    if tweet.user_id == session[:user_id]
      tweet.delete
      redirect '/tweets'
    else
      redirect "/tweets/#{tweet.id}"
    end
  end

  get '/tweets/:tweet_id/edit' do
    @tweet = Tweet.find(params[:tweet_id]) if session.has_key?(:user_id) && params.has_key?(:tweet_id)
    if session.has_key?(:user_id) && @tweet.user_id == session[:user_id]
      erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:tweet_id' do
    tweet = Tweet.find(params[:tweet_id])
    if !params[:content].empty?
      tweet.update(content: params[:content])
      redirect "/tweets/#{tweet.id}/edit"
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end
end
