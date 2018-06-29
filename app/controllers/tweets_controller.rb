class TweetsController < ApplicationController

    get '/tweets/new' do
      erb :'/tweets/create_tweet'
    end

    get '/tweets' do
      @tweets = Tweet.all
        erb :'/tweets/tweets'
    end

    get '/tweets/:id' do
    end

    get '/tweets/:id/edit' do
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    end

    get '/tweets/:id/delete' do
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete
      reditect to '/tweets'
    end
end
