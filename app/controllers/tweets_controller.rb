class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params["content"])
    @tweet.user_id = session[:user_id]
    @tweet.save
    erb :'/tweets/tweets'
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end
end
