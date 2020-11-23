class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      @tweet = Tweet.new(:content => params[:content])
      @user = User.find(session[:user_id])
      @user.tweets.push(@tweet)
      @user.save
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      @user = User.find(session[:user_id])
      erb :'/tweets/tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      @user = User.find(session[:user_id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  #update
  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(:content => params[:content])
    redirect '/tweets'
  end

end
