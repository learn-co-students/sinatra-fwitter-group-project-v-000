require 'rack-flash'
class TweetsController < ApplicationController
  # use Rack::Flash

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      # binding.pry
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets/new' do
    if params[:content].empty?
      redirect to '/tweets/new'
    else
      @tweet = Tweet.new(content:params[:content],user_id:session[:user_id])
      @tweet.save
    end
  end

  get '/tweets/:tweet_id' do
    if logged_in?
      @user = Tweet.find(params[:tweet_id]).user
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:tweet_id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:tweet_id])
      @user = @tweet.user
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:tweet_id/edit' do
    @tweet = Tweet.find(params[:tweet_id])
    # binding.pry
    @tweet.update(content:params[:content])
    @tweet.save
  end

  delete '/tweets/:tweet_id/delete' do
    @tweet=Tweet.find(params[:tweet_id])
    @tweet.delete if @tweet.user_id == session[:user_id]
    redirect to '/tweets'
  end
end
