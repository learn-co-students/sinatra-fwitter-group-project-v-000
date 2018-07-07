require './config/environment'

class TweetsController < ApplicationController

  get '/tweets/:id/edit' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
    redirect '/tweets' if @tweet.user_id != session[:user_id]
    erb :"/tweets/edit_tweet"
  end
  patch '/tweets/:id' do
    redirect '/login' if !logged_in?
    redirect "/tweets/#{params[:id]}/edit" if params[:content].length == 0
    @tweet = Tweet.find(params[:id])
    redirect '/tweets' if @tweet.user_id != current_user.id
    @tweet.content = params[:content]
    @tweet.save
    redirect '/tweets'
  end
  get '/tweets/new' do
    redirect "/login" if !logged_in?
    erb :"/tweets/create_tweet"
  end

  post '/tweets' do
    redirect "/login" if !logged_in?
    # content required in form but just in case someone bypasses form
    redirect '/tweets/new' if params[:content].length == 0
    user = User.find(session[:user_id])
    tweet = Tweet.create(:content => params[:content])
    user.tweets << tweet
    user.save
    redirect "/tweets"
  end

  get '/tweets/:id' do
    redirect "/login" if !logged_in?
    @tweet = Tweet.find(params[:id])
    @user = User.find(@tweet.user_id)
    erb :"/tweets/show_tweet"
  end

  get '/tweets' do
    redirect "/login" if !logged_in?
    @user = current_user
    # sort tweets so oldest is displayed first
    @tweets = Tweet.all.sort {|t1,t2| t2.created_at <=> t1.created_at }
    @user_tweets = Tweet.all.find_all {|tweet| tweet.user_id == current_user.id}
    @user_tweets.sort {|t1,t2| t2.created_at <=> t1.created_at }
    erb :"/tweets/tweets"
  end

  delete '/tweets/:id/delete' do
    puts "Tweets delete id= #{params[:id]}"
    redirect "/login" if !logged_in?
    @tweet = Tweet.find(params[:id])
    redirect "/tweets/#{params[:id]}" if current_user.id != @tweet.user_id
    Tweet.delete(params[:id])
    redirect '/tweets'
  end
end
