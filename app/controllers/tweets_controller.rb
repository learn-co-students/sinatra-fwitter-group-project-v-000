
class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get "/tweets/new" do
    erb :"/tweets/create_tweet"
  end

  post "/tweets" do
    binding.pry
  end

end
