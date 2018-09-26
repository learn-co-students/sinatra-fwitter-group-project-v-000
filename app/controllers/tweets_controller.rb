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
    @tweet = Tweets.find_by_id(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    erb :'tweets/show_tweet'
  end

  patch '/tweets/:id/edit' do
    erb :'/tweets/edit_tweet'
  end

  post '/tweets/id' do
    redirect '/tweets/show_tweet'
  end

  post '/tweets/:id/delete' do
    redirect '/tweets/show_tweet'
  end

end
