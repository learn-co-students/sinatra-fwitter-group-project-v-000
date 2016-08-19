require 'pry'

class TweetController < ApplicationController

  get '/tweets' do
    erb :"/tweets/index"
  end

  get '/tweets/new' do
    erb :"/tweets/new"
  end

  post '/tweets' do
    @tweet = Tweet.create(params)

    redirect to "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    erb :"/tweets/show"
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])

    erb :"/tweets/edit"
  end

  get '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])

    erb :"/tweets/delete"
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    @tweet.save

    redirect to "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect "/tweets"
  end


end
