class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect to "/tweets/new"
    else
      tweet = current_user.tweets.create(content: params[:content])
      redirect to "/tweets/#{tweet.id}"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if 
    @tweet.update(content: params[:content])
    if @tweet.save
      redirect to '/tweets'
    else
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/id/delete' do

  end






end
