class TweetsController < ApplicationController

  before do
    unless logged_in?
      redirect '/login'
    end
  end
  
  get '/tweets' do
    @user = current_user
    @tweets = Tweet.all
    erb :tweets
  end

  get '/tweets/new' do
    erb :new_tweets  
  end

  post '/tweets' do
    tweet = Tweet.new(params[:tweet])
    if tweet.user_id == current_user.id && tweet.save
      redirect "/tweets/#{tweet.id}" 
    else
      redirect '/tweets/new' 
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :show_tweet
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :edit_tweet
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if tweet.update(params[:tweet])
      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{tweet.id}/edit"
    end    
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id && tweet.delete
      redirect '/tweets'
    else
      redirect "/tweets/#{tweet.id}"
    end
  end
end
