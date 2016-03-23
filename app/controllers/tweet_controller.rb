class TweetController < ApplicationController
  
  get '/tweets' do
    @tweet = Tweet.all
    erb :'/tweets/tweets'
  end

  post '/tweets' do
    @tweet = Tweet.create(params["tweet"])
    if params["tweet"]["content"].empty?
      redirect :'/tweets/new', locals: {message: "Your tweet was empty."}
    else
      erb :'/tweets/show', locals: {message: "Successfully created tweet."}
    end
  end

  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end
end
