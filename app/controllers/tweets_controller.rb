class TweetsController < ApplicationController

  get '/tweets' do
    "You are logged in as #{session[:email]}"
  end


  get '/tweets' do
    @tweets = Tweet.all
    erb :"/tweets/index"
  end

  get '/tweets/new' do
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

  delete '/tweets/:id/delete' do
    @tweets = Tweet.find(params[:id])
    @tweets.delete
    erb :"/delete"
  end

end
