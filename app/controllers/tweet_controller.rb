require './config/environment'

class TweetController < ApplicationController

  get "/tweets" do
    if logged_in?
      @tweets = Tweet.all
      erb :"/tweets/index"
    else
      redirect to "/login"
    end
  end

  get "/tweets/new" do
    logged_in? ? (erb :"/tweets/new") : (redirect to "/login")
  end

  post "/tweets" do
    @tweet = Tweet.create(content: params[:content])
    if logged_in? && @tweet.valid?
      current_user.tweets << @tweet
      @tweet.save ? (redirect to "/tweets") : (redirect to "/tweets/new")
    else
      redirect to "/login"
    end
  end

  get "/tweets/:id" do
    @tweet = Tweet.find_by_id(params[:id])
    logged_in? ? (erb :"tweets/show") : (redirect to "/login")
  end

end
