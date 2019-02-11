require 'pry'
class TweetsController < ApplicationController

  get '/tweets' do

    if logged_in?
      @tweets = Tweet.all
      @user = User.find_by_id(session[:user_id])
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    #binding.pry
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    #binding.pry

    if !params[:content].empty? && logged_in?
      @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
#binding.pry
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if Tweet.find_by_id(params[:id]) && Tweet.find_by_id(params[:id]).user_id == session[:user_id] && logged_in?
      @tweet = Tweet.find_by_id(params[:id])
#      binding.pry
      erb :'tweets/show_tweet'
    else
      redirect '/tweets'
    end
  end

  get '/tweets/:id/edit' do
    if Tweet.find_by_id(params[:id]) && Tweet.find_by_id(params[:id]).user_id == session[:user_id] && logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/tweets'
    end
  end

  post '/tweets/:id' do
    if !params[:content].empty?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
    end
      redirect "/tweets/#{@tweet.id}"
  end

  post 'tweets/:id/delete' do
    if Tweet.find_by_id(params[:id]) && Tweet.find_by_id(params[:id]).user_id == session[:user_id] && logged_in?
      Tweet.find_by_id(params[:id]).delete
    end
      redirect '/tweets'
  end
end
