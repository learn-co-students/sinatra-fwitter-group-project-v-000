class TweetsController < ApplicationController

  get '/tweets/:id/edit_tweet' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end
end
