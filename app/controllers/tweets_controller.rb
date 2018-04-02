require 'pry'

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

    if logged_in?
      if params[:content] == ""
        redirect to "/tweets/new"
      else
        @tweet = Tweet.new(content: params[:content])
        @tweet.user_id = current_user.id
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
      end
    else
      redirect to '/login'
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
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if !logged_in?
      redirect to '/login'
    elsif params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else @tweet = Tweet.find_by_id(params[:id])
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    if !logged_in?
      redirect to '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
    end
    if
      @tweet && @tweet.user == current_user
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/login'
    end

  end



end
