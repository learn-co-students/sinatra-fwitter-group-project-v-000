class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    erb :'tweets/new'
  end

  post '/tweets' do
    erb :'/tweets'
  end

  get '/tweets/:id' do
    @tweet = Tweets.find_by(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    erb :'/tweets/edit_tweet'
  end

  post '/tweets/id' do
    redirect ''
  end

end
