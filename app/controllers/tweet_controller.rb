class TweetController < ApplicationController
  get '/tweets' do
    if logged_in?
      @all_tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/new' do
    if logged_in?
      current_user
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do
    if params[:content] != "" 
      Tweet.create(content: params[:content], user_id: current_user.id)
    else
      redirect '/tweets/new'
    end
  end
  
  get '/tweets/:tweet_id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:tweet_id])
    else
      redirect '/login'
    end
    erb :'tweets/show_tweet'
  end
  
  get '/tweets/:tweet_id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:tweet_id])
    else
      redirect '/login'
    end
    erb :'/tweets/edit_tweet'
  end
  
  post '/tweets/:tweet_id' do
    if logged_in?
      redirect "tweets/#{params[:tweet_id]}/edit" if params[:content] == ""
      @tweet = Tweet.find_by_id(params[:tweet_id])
      @tweet.content = params[:content]
      @tweet.save
    else
      redirect '/login'
    end
    erb :'tweets/show_tweet'
  end
  
  post '/tweets/:tweet_id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:tweet_id])
      @tweet.delete if @current_user.id == @tweet.user.id
    else
      redirect '/login'
    end
    redirect '/tweets'
  end
  
  
  
end