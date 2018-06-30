class TweetsController < ApplicationController

  get '/tweets' do
    if Helper.new.is_logged_in?(session)
      @user = User.find(session[:user_id])
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if Helper.new.is_logged_in?(session)
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
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:tweet_id' do
    if Helper.new.is_logged_in?(session)
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
    if Helper.new.is_logged_in?(session)
      @tweet = Tweet.find(params[:tweet_id])
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
