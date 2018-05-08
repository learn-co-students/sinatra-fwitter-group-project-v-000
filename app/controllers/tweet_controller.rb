class TweetController < ApplicationController

  get "/tweets" do
    @tweets = Tweet.all
    erb :"tweets/tweets"
  end

  get '/tweets/new' do
    erb :"tweets/create_tweet"
  end

  # post '/tweets' do
  #   binding.pry
  #   @tweet = Tweet.find_by(params)
  #   redirect "/tweets/#{@tweet.id}" 
  # end
end
