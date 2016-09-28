require 'pry'

class TweetController < ApplicationController

  get '/tweets' do

    if !logged_in?
      redirect to '/login'
    else
      @all_tweets = Tweet.all.reverse
      @user_tweets = current_user.tweets
      erb :'tweets/show'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if (params[:tweet][:content]).empty?
      redirect to '/tweets/new'
    else
      @tweet = current_user.tweets.create(content: params[:tweet][:content])
      redirect to '/tweets'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_individual_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])

    if logged_in? && current_user.id == @tweet.user_id
      erb :'tweets/edit'
    else
      redirect to '/login'
    end
  end



  post '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])

    if params[:tweet][:content].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    elsif @tweet.user_id == current_user.id
      @tweet.update(params[:tweet])
      redirect to '/tweets'
    else
      redirect to "/tweets"
    end
  end

  get '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])

      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end


end
