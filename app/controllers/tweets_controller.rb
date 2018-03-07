class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
    if @tweet.valid?
      @tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && @tweet.user_id == session[:user_id]
      erb :'/tweets/edit_tweet'
    else
      redirect '/tweets'
    end
  end

end
