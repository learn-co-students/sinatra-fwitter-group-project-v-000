require 'pry'
class TweetController < ApplicationController

  get '/tweets' do
    #binding.pry
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(content:params[:content],user_id:session[:user_id])
    if @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = User.find(@tweet.user_id)
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    #binding.pry
    if logged_in? && @tweet.user_id == session[:user_id]
      erb :'tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if @tweet.update(content:params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  patch '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == session[:user_id]
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end

end
