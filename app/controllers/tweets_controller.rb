class TweetsController < ApplicationController
  get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect '/signup'
    end
  end
end
