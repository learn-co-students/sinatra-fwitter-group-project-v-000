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
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
	end

  get '/tweets/:id/edit' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.where(["id = ? and user_id = ?", "#{params[:id]}", "#{current_user.id}"]).first
    erb :'/tweets/edit'
	end

  post '/tweets' do
#    tweet = Tweet.create(user_id: current_user.id, content: params[:content])
    tweet = current_user.tweets.create(content: params[:content])
    redirect '/tweets/new'
  end

  post '/tweets/:id' do
    tweet = Tweet.where(["id = ? and user_id = ?", "#{params[:id]}", "#{current_user.id}"]).first
    if tweet.update(content: params[:content])
      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  post '/tweets/:id/delete' do
    redirect '/login' if !logged_in?
    tweet = Tweet.where(["id = ? and user_id = ?", "#{params[:id]}", "#{current_user.id}"]).first
    tweet.delete if !tweet.nil?
    redirect '/tweets'
	end

end
