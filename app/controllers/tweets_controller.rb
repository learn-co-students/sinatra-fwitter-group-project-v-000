class TweetsController < ApplicationController
  get '/tweets/new' do
    erb :'/tweets/create_tweets'
  end

  post '/tweets' do
    @tweet = Tweet.create(params[:tweet])
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show_tweets'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/edit_tweets'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(content: params[:tweet][:content])
    @tweet.save

    redirect "/tweets/#{@tweet.id}"
  end
end
