class TweetController < ApplicationController
  include Authable::InstanceMethods

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.new(content: params[:content])
    if logged_in? && tweet.valid?
      current_user.tweets << tweet
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end


  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets' do

  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if logged_in? && current_user.id == tweet.user_id
      Tweet.destroy(tweet.id)
      redirect '/tweets'
    elsif logged_in?
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
end
