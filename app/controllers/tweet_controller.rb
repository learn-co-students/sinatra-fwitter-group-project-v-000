require 'pry'

class TweetController < ApplicationController

  get '/tweets' do
    @user = User.find_by_id(session[:user_id])

    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      flash[:message] = "Please create an account"
      erb :'/users/new'
    else
      erb :'tweets/new'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @user = User.find_by_id(@tweet.user_id)
    erb :'/tweets/edit_tweet'
  end

  post '/tweets' do
    @user = User.find_by_id(session[:user_id])
    @tweet = Tweet.create(content: params[:content], user_id: @user.id, time: Time.new.strftime("%Y-%m-%d %H:%M:%S"))
    # redirect to "/tweets/#{@tweet.id}"
    redirect to '/tweets'

  end

end