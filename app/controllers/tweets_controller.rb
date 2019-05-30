class TweetsController < ApplicationController

  get '/tweets' do
    # binding.pry
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    @new_tweet = Tweet.create(content: params[:content])
    @all_tweets = Tweet.all
    erb :'/tweets/new'
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content])
    @tweet.save
  end

  get '/tweets/:id' do

  end

  get '/tweets/:id/edit' do

  end

  post '/tweets/:id' do

  end

  post '/tweets/:id/delete' do

  end

  # get '/tweets' do
  # end


end
