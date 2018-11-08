class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets_index'
    else redirect '/login'
    end
  end

  # get '/tweets/:id' do
  #   erb :show_tweets
  # end
end
