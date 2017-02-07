class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :'tweets/new'
  end

  post '/tweets' do
    tweet = Tweet.new(params[:tweet])
    tweet.user = current_user
    if tweet.save
      redirect to '/tweets'
    else
      flash[:tweet_errors] = tweet.errors.full_messages.join(", ")
      redirect to '/tweets/new'
    end
  end

  get '/tweets' do
    if logged_in?
      @tweets = current_user.tweets
      erb :'tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:slug' do
    if logged_in?
      @tweet = current_user.tweets.find { |tw| tw.slug == params[:slug] }
      if @tweet
        erb :'tweets/show'
      else
        erb :'tweets/failure'
      end
    else
      redirect to '/login'
    end
  end

end
