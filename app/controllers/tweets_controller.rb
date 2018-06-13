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
    @tweets = Tweet.all
    @users = User.all
    erb :'/tweets/create_tweet'

  end


end
