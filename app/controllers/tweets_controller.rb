class TweetsController < ApplicationController

  get '/tweets' do #shows all tweets
    if logged_in?
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do #CREATE: creates new tweets
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

end
