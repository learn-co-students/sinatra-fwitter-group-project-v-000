require 'pry'

class TweetController < ApplicationController
  get '/tweets' do

    if logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    tweet = current_user.tweets.find_by(id: params[:id])
    if tweet && tweet.destroy
      redirect "/tweets"
    else
      redirect "/tweets/#{tweet.id}"
    end

  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect "/login"
    end
  end

  delete "/tweets/:id/delete" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        @tweet.save
      end
    end
    redirect "/tweets"
  end
end
