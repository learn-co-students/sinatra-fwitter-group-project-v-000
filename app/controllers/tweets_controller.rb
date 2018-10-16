require 'rack-flash'

class TweetsController < ApplicationController
  use Rack::Flash

  get '/tweets' do
    @tweets = Tweet.all.sort_by { |t| t.title }
    if logged_in?
      erb :'/tweets/tweets'
    else
      flash[:message] = "You must be logged in first."
      redirect to '/login'
    end
  end


  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      flash[:message] = "You must be logged in first."
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      flash[:message] = "You must be logged in first."
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      flash[:message] = "You must be logged in first."
      redirect to 'login'
    end
  end

  post '/tweets' do
    if logged_in? && params[:content] != ""
      @tweet = current_user.tweets.create(title: params[:title], content: params[:content])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    elsif logged_in? && params[:content] == ""
      flash[:message] = "Must Enter Tweet Content."
      redirect to '/tweets/new'
    else
      flash[:message] = "You must be logged in first."
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && params[:content] != ""
      @tweet.update(title: params[:title], content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    elsif logged_in? && params[:content] == ""
      flash[:message] = "Must Enter Tweet Content."
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      flash[:message] = "You must be logged in first."
      redirect to '/login'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && current_user == @tweet.user
      @tweet.delete
      flash[:message] = "Tweet Deleted Successfully?"
      redirect to '/tweets'
    else
      flash[:message] = "You must be logged in first."
      redirect to '/login'
    end
  end
end
