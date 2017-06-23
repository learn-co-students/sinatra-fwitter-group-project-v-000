class TweetsController < ApplicationController

  get 'tweets/tweets' do
    # TODO: Check for login
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    # TODO: Check for login
    erb :'tweets/create_tweet'
  end

  get '/tweets/:id' do
    # TODO: Check for login
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    # TODO: Check for login, match user
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit_tweet'
  end

  post '/tweets' do
    @tweet = Tweet.new(params[:tweet]) #TODO: replace 'Tweet' with 'current_user.tweets'
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
    #TODO: check if logged in
    @tweet = Tweet.find(params[:id])
    #TODO: check if tweet belongs to current_user
    @tweet.delete
    redirect '/tweets'
  end

end
