class TweetsController < ApplicationController

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/tweets' do

    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
     else
      redirect to "/login"
    end

  end


  get '/tweets/new' do

      if logged_in?
     @tweets = Tweet.all
    erb :'/tweets/create_tweet'
    else
      redirect to "/tweets"
    end

    end


end
