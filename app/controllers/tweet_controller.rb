class TweetController < ApplicationController

  get "/tweets" do
    @tweets = Tweet.all
    erb :"tweets/tweets"
  end

  post '/tweets' do
    # @tweet = Tweet.find_by(params)
    # redirect "/tweets/#{@tweet.id}" 
  end

  get '/tweets/new' do
    erb :"tweets/create_tweet"
  end
end
