require './config/environment'

class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  get '/tweets' do
    erb :'/tweets/tweets'
  end

  post '/tweets' do
    erb :'/tweets/tweets'
  end

  get '/tweets/:id' do
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    erb :'/tweets/edit_tweet'
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
  end

end
