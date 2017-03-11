require './config/environment'

class TweetController < ApplicationController

  get '/tweets' do
    redirect '/login' if !logged_in?
    @tweets = Tweet.all.order(:id)
    erb :'/tweets/index'
	end

  get '/tweets/new' do
    redirect '/login' if !logged_in?
    erb :'/tweets/new'
	end

  get '/tweets/:id' do
    redirect '/login' if !logged_in?
    @tweet = current_user.tweets.find_by(id: params[:id])
    erb :'/tweets/show'
	end

  get '/tweets/:id/edit' do
    redirect '/login' if !logged_in?
    @tweet = current_user.tweets.find_by(id: params[:id])
    erb :'/tweets/edit'
	end

  post '/tweets' do
    tweet = current_user.tweets.create(content: params[:content])
    redirect '/tweets/new'
  end

  patch '/tweets/:id' do
    tweet = current_user.tweets.find_by(id: params[:id])
    if tweet && tweet.update(content: params[:content])
      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id' do
    tweet = current_user.tweets.find_by(id: params[:id])
    if tweet && tweet.destroy
      redirect "/tweets"
    else
      redirect "/tweets/#{params[:id]}"
    end
	end

end
