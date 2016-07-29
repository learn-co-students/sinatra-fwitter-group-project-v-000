class TweetsController < ApplicationController

  # Create
  get '/tweets/new' do
    erb :'/tweets/new'
  end

  post '/tweets' do
    @tweet = Tweet.create(params[:content])
    redirect to "/tweets/#{tweet.id}"
  end

  # Read #
  get '/tweets' do
    @tweets = Tweet.all
    erb :'/tweets/index'
  end
  
  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end

  # Update #
  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit'
  end

  post '/tweets/:id' do
    @tweet
  end

  # Delete #
  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
  end

end
