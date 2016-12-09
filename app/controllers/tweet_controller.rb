require './config/environment'

class TweetController < ApplicationController
  
  get '/tweets' do
    @user = current_user
    if !current_user.nil?
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/new' do
    @user = current_user
    if !current_user.nil?
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/show_user_tweets' do
    @user = current_user
    erb :'/tweets/show_user_tweets'
  end
  
  get '/tweets/:tweet_id' do
    if logged_in?
      @tweet = current_tweet
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/:tweet_id/edit' do
    @user = current_user
    if !current_user.nil? && current_tweet.user_id == current_user.id
     @tweet = current_tweet
     erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end
 
  post '/tweets' do
    if !params[:content].empty?
      @user = current_user
      @tweet = Tweet.create(params)
      erb :'/tweets/show_user_tweets'
    else
      redirect to '/tweets/new'
    end
  end
  
  patch '/tweets/:tweet_id' do
   if !params[:content].empty?
     @tweet = current_tweet
     @tweet.content = params[:content]
     @tweet.save
     redirect to '/tweets'
   else
     redirect to "/tweets/#{params[:tweet_id].to_i}/edit"
   end
  end
  
  post '/tweets/:id/delete' do
    if current_user.id == current_tweet.user_id
      Tweet.delete(params[:id])
    end
    redirect to '/tweets'
  end
 
end