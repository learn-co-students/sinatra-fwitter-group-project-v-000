class TweetsController < ApplicationController

  get '/tweets' do

    @tweets = Tweet.all

    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params[:content], user_id: session[:id])

    redirect to '/tweets/#{@tweet.id}'
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
    @tweet.update(content: params[:content])
    redirect to '/tweets'
  end

  delete '/tweets/delete/:id' do
    tweet = Tweet.find_by(id: params[:id])
    tweet.destroy
    redirect to '/tweets'
  end


end
