class TweetController < ApplicationController

  get '/tweets' do
    # binding.pry
    @tweets = Tweet.all
    erb :"tweets/tweets"
  end

  get '/tweets/new' do
    erb :"tweets/create_tweet"
  end
end
