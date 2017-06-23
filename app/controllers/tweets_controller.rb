class TweetsController < ApplicationController

  get 'tweets/tweets' do
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit_tweet'
  end

  post '/tweets' do
    @tweet = Tweet.new(params[:tweet]) #replace Tweet with current_user.tweets
    if @tweet.valid?
      @tweet.save
      redirect "tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  patch 'tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.name
    redirect "/tweets/#{@tweet.id}"
  end

  delete 'tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete
    redirect '/tweets'
  end

end
