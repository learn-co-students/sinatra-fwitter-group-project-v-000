class TweetsController < ApplicationController

  get '/tweets' do
    erb :'tweets/tweets_index'
  end

  get '/tweets/:id' do
    erb :show_tweets
  end
end
