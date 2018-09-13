class TweetsController < ApplicationController

  get '/tweet/new' do
    erb :'/tweets/new'
  end

  post '/tweets' do
    @tweet = Tweet.create(params)
    @tweet.save
    redirect to '/tweets'
  end

  get '/tweets' do
    erb :'/tweets/tweets'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect to '/tweets#{@tweet.id}'
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
  end


end
