class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'/tweets/create_tweet'
    else
      '/'
    end
  end

  post '/tweets' do
    @user = current_user
    @tweet = Tweet.new(:content => params[:content], :user_id => @user.id)
    if @tweet.save
      redirect "/users/#{@user.slug}"
    else
      erb :'/tweets/create_tweet'
    end
  end

end