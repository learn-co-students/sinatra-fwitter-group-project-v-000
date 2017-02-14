class TweetsController < ApplicationController

  # CREATE TWEET
  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

  post '/tweets' do
    
  end
end
