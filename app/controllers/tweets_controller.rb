class TweetsController < ApplicationController

  get '/tweets' do
    "how about this one?"
  end

  get '/tweets/new' do
    erb :'tweets/new'
  end

  post '/tweets' do
    @tweet = Tweet.new(params)
    @tweet.save
    redirect 'tweets/#{@tweet.id}'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(params[:id])
    erb :'tweets/edit'
  end

end
