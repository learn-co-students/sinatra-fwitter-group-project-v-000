require './config/environment'

class TweetController < ApplicationController

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'tweets/tweets'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    unless params[:content].empty?
      @tweet = Tweet.create(:content => params[:content])
      @tweet.user_id = current_user.id
      @tweet.save
      erb :"tweets/show_tweet"
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
    if logged_in?
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    unless params[:content].empty?
      @tweet.content = params[:content]
      @tweet.save
      erb :'tweets/show_tweet'
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user_id == current_user.id
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
