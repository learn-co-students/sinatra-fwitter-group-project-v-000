class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    erb :"/tweets/index"
  end

  get '/tweets' do
    @tweets = Tweet.all
    erb :"/tweets/new"
  end

  post '/tweets'do

  end

  get '/tweets/:id' do
    raise params.inspect
    @tweets = Tweet.find(params[:id])
    erb :"/tweets/show"
  end

end
