class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      # binding.pry
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end
end
