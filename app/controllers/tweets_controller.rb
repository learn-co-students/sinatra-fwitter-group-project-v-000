class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      list_tweets
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    redirect '/tweets/new' unless user_credentialed?
    create_tweet
    @tweet.user_id = session[:user_id]
    @tweet.save
    redirect '/tweets'
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      find_tweet
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      find_tweet
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    find_tweet
    redirect "/tweets/#{@tweet.id}/edit" if params[:content].blank?
    @tweet.update(content: params[:content])
    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id' do
    find_tweet
    @tweet.delete if tweet_belongs_to_user
    redirect '/tweets'
  end

  helpers do
    def list_tweets
      @tweets = Tweet.all
    end

    def create_tweet
      @tweet = Tweet.create(params)
    end

    def find_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_belongs_to_user
      @tweet.user_id == session[:user_id]
    end
  end

end
