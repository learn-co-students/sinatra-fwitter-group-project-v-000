class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    erb :'/tweets/tweets'
  end

  # get '/tweets/new' do
  #   erb :'/tweets/new'
  # end
  #
  # post '/tweets' do
  #   @tweet = Tweet.find_or_create_by(:content => params[:content])
  #   @tweet.user_id = session[:id]
  #   @tweet.save
  #   erb :'/tweets/show_tweet'
  # end

end
