class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  get '/tweets' do
    erb :'/tweets/tweets'
  end

  post '/tweets' do
    @tweet = Tweet.create(params[:tweet])
    @tweet.save
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      redirect to erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets/:id/delete' do
    if Helpers.is_logged_in?(session)
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end
end
