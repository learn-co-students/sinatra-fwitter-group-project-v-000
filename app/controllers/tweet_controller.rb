class TweetController < ApplicationController

  get '/tweets' do
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    erb :create_tweet
  end

  post '/tweets/' do
     Tweet.new
  end


end
