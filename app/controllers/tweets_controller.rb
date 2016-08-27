class TweetsController < ApplicationController


  get '/tweets' do
    @tweets = Tweet.all 
    erb :'/tweets/tweets'
    end

  get '/tweets/new' do 
    erb :'tweets/new'
  end

  get '/tweets/:id' do
    # binding.pry
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show_tweets'
  end

  post '/tweets' do
    @tweets = Tweet.create(content: params[:content])
    redirect "/tweets/#{tweet.id}"
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params[:name]
    @tweet.save
    erb :'/tweets/show_tweets'
  end


end