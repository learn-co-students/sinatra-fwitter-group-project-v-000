class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/create_tweet' do
    erb :'tweets/create_tweet'
  end

  get '/tweets/edit_tweet' do
    erb :'tweets/edit_tweet'
  end

  get '/tweets/show_tweet' do
    erb :'tweets/show_tweet'
  end
end
