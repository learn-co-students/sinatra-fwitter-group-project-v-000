class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    erb :"tweets/tweets"
  end

  get '/tweets/new' do
    erb :"tweets/new"
  end

  post '/tweets' do
    @tweet = Tweet.create(params[:tweet])
    #some logic to associate it with the logged in User
    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :"tweets/show_tweet"
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :"tweets/edit_tweet"
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(params[:tweet])
    #user logic
    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete
    redirect "/tweets"
  end

end
