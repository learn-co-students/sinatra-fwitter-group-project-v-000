class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/:slug/tweets' do
    @user = User.find(session[:user_id])
    @tweets = Tweet.all
    if logged_in?
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      user = User.find(session[:user_id])
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @user = User.find(session[:user_id])
    tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
    if tweet.content != nil && tweet.content != ""
      tweet.save
      redirect "/#{@user.slug}/tweets" #redirect to tweet show page
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets' do
    if logged_in?
      erb :'/tweets/index'
    else
      erb :'/users/login'
    end
  end

end
