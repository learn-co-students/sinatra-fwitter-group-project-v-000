require './config/environment'

class TweetController < ApplicationController
  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
    if !!@tweet.id
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if !logged_in?
      redirect '/login'
    elsif @tweet.user_id == current_user.id
      erb :'tweets/edit_tweet'
    else
      redirect '/tweets'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])

    if current_user.id == @tweet.user_id
      @tweet.destroy
      redirect "/tweets"
    else
      redirect "/tweets"
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(content: params[:content])
    if @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end
end
