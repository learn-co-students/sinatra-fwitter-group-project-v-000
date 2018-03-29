class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect to '/'
    else
      @tweets = current_user.tweets
      erb :'tweets/index'
    end
  end

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  post '/tweets' do
    @tweet = current_user.tweets.build(params)
    current_user.save
    redirect to '/tweets'
  end

  get '/tweets/:id' do
    current_tweet
    erb :'/tweets/show'
  end

  get '/tweets/:id/edit' do
    current_tweet
    erb :'/tweets/edit'
  end

  patch '/tweets/:id' do
    current_tweet.update(params)
    redirect to "/tweets/#{current_tweet.id}"
  end

  delete '/tweets/:id/delete' do
    current_tweet.delete
    redirect to '/tweets'
  end

end
