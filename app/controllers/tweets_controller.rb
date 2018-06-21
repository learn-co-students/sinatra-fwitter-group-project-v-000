class TweetsController < ApplicationController

  get '/tweets' do
    redirect to '/login' if !logged_in?
    @tweets = Tweet.all
    erb :'tweets/index'
  end

  get '/tweets/new' do
    redirect to '/login' if !logged_in?
    erb :'tweets/new'
  end
end
