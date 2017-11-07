class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      # binding.pry
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets/new' do
    if logged_in? && !params["content"].empty?
      @user = current_user

      @tweet = Tweet.new(content: params["content"])
      @tweet.user = @user
      @tweet.save
    end
    redirect to '/tweets/new'
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = @tweet.user
      erb :'/tweets/show_tweet'
    else
      erb :login
    end
  end
end
