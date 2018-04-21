class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

  post '/tweets/new' do
    if !params[:content] == ""
      @tweet = Tweet.create(params)
      @tweet.save
    end
  end
end
