class TweetsController < ApplicationController
  get '/tweets' do
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  post '/tweets' do
    @tweet = Tweet.create(params[:tweet])
    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show_tweet'
  end
end
