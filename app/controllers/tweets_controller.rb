class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect to '/tweets/new'
    elsif logged_in?
      @tweet = Tweet.find_or_create_by(:content => params[:content])
      @tweet.user_id = session[:user_id]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do

    # redirect to "/tweets/show_tweet"
  end

end
