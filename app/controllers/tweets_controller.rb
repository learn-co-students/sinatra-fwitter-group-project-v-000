class TweetsController < ApplicationController

  get "/tweets/new" do
    erb :"/tweets/create_tweet"
  end

  post "/tweets" do
    @tweet = Tweet.create(params)
    erb :"/tweets/tweets"
  end

  get "tweets/:id/edit" do
    @tweet = Tweet.find_by(id: params[:id])
    erb :"/tweets/edit_tweet"
  end

  get "tweets/:id" do
    @tweet = Tweet.find_by(id: params[:id])
    erb :"/tweets/show_tweet"
  end

  patch "tweets/:id" do
    @tweet = Tweet.find_by(id: params[:id])
      # change name/whatever according to params
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  delete "tweets/:id/delete" do
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.clear
  end




end
