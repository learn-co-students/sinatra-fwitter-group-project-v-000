class TweetsController < ApplicationController

  get '/tweets' do
    redirect to '/login' if !logged_in?
    tweets = Tweet.all
    erb :'tweets/index'
  end

end
