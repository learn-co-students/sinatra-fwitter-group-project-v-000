class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    erb :'tweets/new'
  end

  post '/tweets' do
    @tweet = Tweets.create(:content =>params[:content])
    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    @tweet = Tweets.find_by_id(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweets.find_by_id(params[:id])
    erb :'tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    @tweet = Tweets.find_by_id(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  post '/tweets/:id/delete' do
    @tweet = Tweets.find_by_id(params[:id])
    @tweet.delete
  end
end
