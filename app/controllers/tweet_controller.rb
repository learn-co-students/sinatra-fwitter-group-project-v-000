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
    if !@user.nil?
     @tweet = current_tweet
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end
 
  post '/tweets/new' do
    if !params[:content].empty?
      @user = User.find_by params[:user_id]
      Tweet.create(params)
      erb :'/tweets/show_user_tweets'
    else
      redirect to '/tweets/new'
    end
  end
  
  post '/tweets/change' do
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
    Tweet.delete(params[:id])
    redirect to '/tweets'
  end
 
end