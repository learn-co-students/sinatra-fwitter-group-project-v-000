class TweetsController < ApplicationController
  set :views, 'app/views/tweets'

  get '/tweets' do
    @tweets = Tweet.all
    erb :index
  end

  get '/tweets/new' do
    erb :new
  end

  post '/tweets' do
    tweet = current_user.tweets.build(params[:tweet])

    if tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end
end