class TweetsController < ApplicationController

  get '/tweets' do
    if !!session[:id]
      @tweets = Tweet.all
      erb :tweets
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if !!session[:id]
      erb :new
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.new(content: params[:content], user_id: session[:id])
    if tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end

  end
end
