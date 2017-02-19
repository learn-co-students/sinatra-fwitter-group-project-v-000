class TweetsController < ApplicationController
  get '/tweets' do
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    @tweet = Tweet.new
    erb :'tweets/create_tweet'
  end
end
