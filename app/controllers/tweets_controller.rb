class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    @tweet = Tweet.create(params[:tweet])
    @tweet.save
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    redirect to erb :'/tweets/show_tweet'
  end

  post '/tweets/:id/delete' do
    erb :'/tweets/show_tweet'
  end
end
