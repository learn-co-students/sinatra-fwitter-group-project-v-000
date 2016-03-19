class TweetsController < ApplicationController

  get "/tweets" do
    erb :"tweets/tweets"
  end

  get "/tweets/new" do
    erb :"tweets/create_tweet"
  end

  get "/tweets/:id" do
    erb :"tweets/show_tweet"
  end

  get "/tweets/:id/edit" do
    erb :"tweets/edit_tweet"
  end

  post "/tweets" do
    @tweet = Tweet.new(params[:tweet])
    @tweet.save
    redirect to "/tweets"
  end

  patch "/tweets/:id" do
    @tweet = Tweet.update(params[:tweet])
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end

end
